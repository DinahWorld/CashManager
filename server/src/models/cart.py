from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.exc import IntegrityError
from src.database.db import db
from collections import OrderedDict


class Cart(db.Model):
    __tablename__ = 'carts'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, ForeignKey('users.id'), unique=True)
    users = relationship('User', back_populates='carts')
    products = relationship('Product', secondary='cart_items', back_populates='carts')

    def __init__(self, user_id):
        self.user_id = user_id

    @staticmethod
    def create(user_id):
        try:
            new_cart = Cart(user_id)
            db.session.add(new_cart)
            db.session.commit()
            return OrderedDict(error=None, status_code=201)
        except IntegrityError:
            db.session.rollback()
            return OrderedDict(error='Cart already exists', status_code=400)
        except Exception as e:
            return OrderedDict(error=str(e), status_code=500)

    @staticmethod
    def get_all():
        try:
            carts = Cart.query.all()
            return OrderedDict(found_carts=carts, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_carts=None, error=str(e), status_code=500)

    @staticmethod
    def get_one(cart_id):
        try:
            cart = Cart.query.get(cart_id)
            if not cart:
                return OrderedDict(found_cart=None, error='Cart not found', status_code=404)

            return OrderedDict(found_cart=cart, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_cart=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_user(user_id):
        try:
            cart = Cart.query.filter_by(user_id=user_id).first()
            if not cart:
                return OrderedDict(found_cart=None, error='Cart not found', status_code=404)
            return OrderedDict(found_cart=cart, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_cart=None, error=str(e), status_code=500)

    @staticmethod
    def get_items_by_user(user_id):
        try:
            query = "SELECT cart_items.id as cart_item_id, carts.user_id, carts.id as cart_id, " \
                    "products.id as product_id, products.name as product_name, " \
                    "products.code as product_code, products.price as product_price FROM carts " \
                    "cross join products right join cart_items on cart_items.cart_id = carts.id " \
                    "and cart_items.product_id = products.id where carts.user_id = " + str(user_id) + ";"

            cart = db.session.execute(query).fetchall()
            if not cart:
                return OrderedDict(found_cart=None, error='No items found', status_code=404)
            return OrderedDict(found_cart=cart, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_cart=None, error=str(e), status_code=500)

