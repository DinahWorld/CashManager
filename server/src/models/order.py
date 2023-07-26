from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.exc import IntegrityError
from src.database.db import db
from collections import OrderedDict


class Order(db.Model):
    __tablename__ = 'orders'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, ForeignKey('users.id'))
    payment_intent_id = db.Column(db.String(255), nullable=True)
    price = db.Column(db.Integer, nullable=True)
    created_at = db.Column(db.DateTime, server_default=db.func.now())
    users = relationship('User', back_populates='orders')
    products = relationship('Product', secondary='order_items', back_populates='orders')

    def __init__(self, user_id, payment_intent_id, price):
        self.user_id = user_id
        self.payment_intent_id = payment_intent_id
        self.price = price

    @staticmethod
    def create(user_id, payment_intent_id, price):
        try:
            new_order = Order(user_id, payment_intent_id, price)
            db.session.add(new_order)
            db.session.commit()

            return OrderedDict(created_order=new_order, error=None, status_code=201)
        except IntegrityError as i:
            db.session.rollback()
            return OrderedDict(created_order=None, error=str(i), status_code=500)
        except Exception as e:
            db.session.rollback()
            return OrderedDict(created_order=None, error=str(e), status_code=500)

    @staticmethod
    def get_all():
        try:
            orders = Order.query.all()
            return OrderedDict(found_orders=orders, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_orders=None, error=str(e), status_code=500)

    @staticmethod
    def get_one(order_id):
        try:
            order = Order.query.get(order_id)
            if order:
                return OrderedDict(found_order=order, error=None, status_code=200)
            return OrderedDict(found_order=None, error='Order not found', status_code=404)
        except Exception as e:
            return OrderedDict(found_order=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_id(order_id):
        try:
            order = Order.query.get(order_id)
            if order:
                return OrderedDict(found_order=order, error=None, status_code=200)
            return OrderedDict(found_order=None, error='Order not found', status_code=404)
        except Exception as e:
            return OrderedDict(found_order=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_user(user_id):
        try:
            orders = Order.query.filter_by(user_id=user_id).all()
            if orders:
                return OrderedDict(found_orders=orders, error=None, status_code=200)
            return OrderedDict(found_orders=None, error='No orders found', status_code=404)
        except Exception as e:
            return OrderedDict(found_orders=None, error=str(e), status_code=500)

    @staticmethod
    def get_by_user_and_order(user_id, order_id):
        try:
            query = "SELECT order_items.id as order_item_id, orders.user_id, orders.id as order_id, " \
                    "products.id as product_id, products.name as product_name, products.code as product_code, " \
                    "products.price as product_price FROM orders " \
                    "cross join products right join order_items on order_items.order_id = orders.id " \
                    "and order_items.product_id = products.id where orders.user_id = " + str(user_id) + "" \
                    " and orders.id = " + str(order_id) + "; " \

            order = db.session.execute(query).fetchall()
            if not order:
                return OrderedDict(found_order=None, error='No order items found', status_code=404)
            return OrderedDict(found_order=order, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_order=None, error=str(e), status_code=500)

