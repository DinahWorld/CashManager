from sqlalchemy.orm import relationship
from sqlalchemy.exc import IntegrityError
from src.database.db import db
import bcrypt
from collections import OrderedDict


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True)
    email = db.Column(db.String(100), unique=True, nullable=False)
    customer_id = db.Column(db.String(100), unique=True, nullable=False)
    payment_method_id = db.Column(db.String(100))
    password = db.Column(db.String(100))
    balance = db.Column(db.Float, default=0)
    carts = relationship('Cart', back_populates='users', uselist=False)
    orders = relationship('Order', back_populates='users', uselist=False)

    def __init__(self, username, email, customer_id, password):
        self.username = username
        self.email = email
        self.customer_id = customer_id
        self.password = password

    @staticmethod
    def create(username, email, customer_id, password):
        try:
            pw_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
            new_user = User(username, email, customer_id, pw_hash)
            db.session.add(new_user)
            db.session.commit()
            return OrderedDict(created_user=new_user, error=None, status_code=201)
        except IntegrityError:
            db.session.rollback()
            return OrderedDict(created_user=None, error='Username or email already exists', status_code=400)

    @staticmethod
    def get_all():
        try:
            users = User.query.all()
            return OrderedDict(found_users=users, error=None, status_code=200)
        except Exception as e:
            OrderedDict(found_user=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_id(user_id):
        try:
            user = User.query.get(user_id)
            if not user:
                return OrderedDict(found_user=None, error='User not found', status_code=404)
            return OrderedDict(found_user=user, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_user=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_username(username):
        try:
            user = User.query.filter_by(username=username).first()
            if not user:
                return OrderedDict(found_user=None, error='User not found', status_code=404)
            return OrderedDict(found_user=user, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_user=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_email(email):
        try:
            user = User.query.filter_by(email=email).first()
            if not user:
                return OrderedDict(found_user=None, error='User not found', status_code=404)
            return OrderedDict(found_user=user, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_user=None, error=str(e), status_code=500)

    @staticmethod
    def update_by_id(user_id, user_data):
        try:
            user = User.query.get(user_id)
            if not user:
                OrderedDict(updated_user=None, error='User not found', status_code=404)

            # email & password cannot be updated
            if 'email' in user_data:
                return OrderedDict(updated_user=None, error='Email cannot be updated', status_code=400)
            if 'password' in user_data:
                return OrderedDict(updated_user=None, error='Password cannot be updated', status_code=400)

            # Update user
            for key, value in user_data.items():
                if value:
                    setattr(user, key, value)

            db.session.commit()
            return OrderedDict(updated_user=user, error=None, status_code=200)
        except IntegrityError:
            db.session.rollback()
            return OrderedDict(created_user=None, error='Username already exists', status_code=400)
        except Exception as e:
            return OrderedDict(updated_user=None, error=str(e), status_code=500)

    @staticmethod
    def delete_by_id(user_id):
        try:
            user = User.query.get(user_id)
            if not user:
                return OrderedDict(error='User not found', status_code=404)

            db.session.delete(user)
            db.session.commit()
            return OrderedDict(error=None, status_code=404)
        except Exception as e:
            return OrderedDict(error=str(e), status_code=500)
