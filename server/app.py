import os
from flask import Flask, make_response
from src.routes import user_route, cart_route, order_route, product_route, auth_route, payment_route
from src.database.db import db
from src.database.schema import ma
import src.models
from src.models.auth_user import User
import src.dummies as dummies
from flask.cli import with_appcontext
import stripe
import click

from flask_login import LoginManager
from src.services.user import get_by_email
import jwt


def create_app(db_url=None):
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DB_URI')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    stripe_keys = {
        "secret_key": os.environ["STRIPE_SECRET_KEY"],
        "publishable_key": os.environ["STRIPE_PUBLISHABLE_KEY"],
    }

    stripe.api_key = stripe_keys["secret_key"]

    register_commands(app)

    db.init_app(app)
    ma.init_app(app)

    login_manager = LoginManager()
    login_manager.init_app(app)

    @login_manager.request_loader
    def load_user_from_request(request):
        auth_headers = request.headers.get('Authorization', '').split()
        if len(auth_headers) != 2:
            return None
        try:
            token = auth_headers[1]
            data = jwt.decode(token, "secret", algorithms=["HS256"])
            user_data = get_by_email(data['sub']).get_json()
            if 'error' in user_data:
                return None

            # Implement required methods & properties using UserMixins
            auth_user = User(user_data)
            return auth_user
        except jwt.ExpiredSignatureError:
            return None
        except (jwt.InvalidTokenError, Exception) as e:
            return None

    @login_manager.unauthorized_handler
    def unauthorized():
        return make_response({'error': 'You are not authorized to access this resource'}, 403)

    with app.app_context():
        db.create_all()

        # Register routes
        app.register_blueprint(user_route)
        app.register_blueprint(cart_route)
        app.register_blueprint(order_route)
        app.register_blueprint(product_route)
        app.register_blueprint(auth_route)
        app.register_blueprint(payment_route)

        return app


@click.command(name='dummy')
@with_appcontext
def dummy():
    # Add dummies data
    dummies.create_dummy_user()
    dummies.create_dummy_product()
    dummies.create_dummy_cart()
    dummies.create_dummy_cart_item()
    dummies.create_dummy_order()
    dummies.create_dummy_order_item()


@click.command(name='reset')
@with_appcontext
def reset():
    # Reset database
    db.drop_all()
    db.create_all()
    print('Database reset')


def register_commands(app):
    """Register CLI commands."""
    app.cli.add_command(dummy)
    app.cli.add_command(reset)


