from src.database.db import db
from sqlalchemy.orm import relationship
from collections import OrderedDict


class Product(db.Model):
    __tablename__ = 'products'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(100))
    name = db.Column(db.String(100))
    price = db.Column(db.Integer)
    is_buyable = db.Column(db.Boolean, default=False)
    carts = relationship('Cart', secondary='cart_items', back_populates='products')
    orders = relationship('Order', secondary='order_items', back_populates='products')

    def __init__(self, code, name, price, is_buyable):
        self.code = code
        self.name = name
        self.price = price
        self.is_buyable = is_buyable

    @staticmethod
    def create(code, name, price, is_buyable):
        try:
            new_product = Product(code, name, price, is_buyable)
            db.session.add(new_product)
            db.session.commit()
            return OrderedDict(error=None, status_code=201)
        except Exception as e:
            return OrderedDict(error=str(e), status_code=500)

    @staticmethod
    def get_all():
        try:
            products = Product.query.all()
            return OrderedDict(found_products=products, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_products=None, error=str(e), status_code=500)

    @staticmethod
    def get_one(code):
        try:
            product = Product.query.filter_by(code=code).first()
            if not product:
                return OrderedDict(found_product=None, error='Product not found', status_code=404)

            return OrderedDict(found_product=product, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(found_product=None, error=str(e), status_code=500)

    @staticmethod
    def update_one(product_id, product_data):
        try:
            product = Product.query.get(product_id)
            if not product:
                return OrderedDict(updated_product=None, error='Product not found', status_code=404)

            # Update product
            for key, value in product_data.items():
                if value:
                    setattr(product, key, value)
            db.session.commit()
            return OrderedDict(updated_product=product, error=None, status_code=200)
        except Exception as e:
            return OrderedDict(updated_product=None, error=str(e), status_code=500)

    @staticmethod
    def delete_one(product_id):
        try:
            product = Product.query.get(product_id)
            if not product:
                return OrderedDict(error='Product not found', status_code=404)

            db.session.delete(product)
            db.session.commit()
            return OrderedDict(error=None, status_code=204)
        except Exception as e:
            return OrderedDict(error=str(e), status_code=500)
