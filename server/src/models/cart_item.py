from sqlalchemy import ForeignKey
from src.database.db import db
from sqlalchemy.exc import IntegrityError
from collections import OrderedDict

class CartItem(db.Model):
    __tablename__ = 'cart_items'
    id = db.Column(db.Integer, primary_key=True)
    cart_id = db.Column(db.Integer, ForeignKey('carts.id'))
    product_id = db.Column(db.Integer, ForeignKey('products.id'))

    def __init__(self, cart_id, product_id):
        self.cart_id = cart_id
        self.product_id = product_id

    @staticmethod
    def create(cart_id, product_id):
        try:
            new_cart_item = CartItem(cart_id, product_id)
            db.session.add(new_cart_item)
            db.session.commit()
            return OrderedDict(created_cart_item=new_cart_item, error=None, status_code=201)
        except IntegrityError as i:
            db.session.rollback()
            return OrderedDict(created_cart_item=None, error='Product not found', status_code=400)
        except Exception as e:
            return OrderedDict(created_cart_item=None, error=str(e), status_code=500)

    @staticmethod
    def delete(cart_id, cart_item_id):
        try:
            cart_item = CartItem.query.filter_by(cart_id=cart_id, id=cart_item_id).first()
            if cart_item is None:
                return OrderedDict(error='Cart item not found', status_code=404)

            db.session.delete(cart_item)
            db.session.commit()
            return OrderedDict(error=None, status_code=204)
        except Exception as e:
            return OrderedDict(error=str(e), status_code=500)
