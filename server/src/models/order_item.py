from sqlalchemy import ForeignKey
from src.database.db import db
from collections import OrderedDict


class OrderItem(db.Model):
    __tablename__ = 'order_items'
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.Integer, ForeignKey('orders.id'))
    product_id = db.Column(db.Integer, ForeignKey('products.id'))

    def __init__(self, order_id, product_id):
        self.order_id = order_id
        self.product_id = product_id

    @staticmethod
    def create(order_item_data):
        try:
            order_id = order_item_data['order_id']
            product_id = order_item_data['product_id']

            order_item = OrderItem(order_id, product_id)
            db.session.add(order_item)
            db.session.commit()
            OrderedDict(created_order_item=order_item, error=None, status_code=201)
        except KeyError as ke:
            return OrderedDict(created_order_item=None, error='Key Not Found : ' + str(ke), status_code=400)
        except Exception as e:
            return OrderedDict(created_order_item=None, error=str(e), status_code=500)

    @staticmethod
    def delete(order_item_id):
        try:
            order_item = OrderItem.query.get(order_item_id)
            db.session.delete(order_item)
            db.session.commit()
            return OrderedDict(deleted_order_item=order_item, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(deleted_order_item=None, error=str(e), status_code=500)
