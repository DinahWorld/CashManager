from src.models import Cart, CartItem
from flask import make_response
from src.schemas.cart import CartSchema
from src.schemas.cart_item import CartItemSchema
from src.models.product import Product
from src.schemas.product import ProductSchema

cart_schema = CartSchema()
carts_schema = CartSchema(many=True)
cart_item_schema = CartItemSchema()
carts_item_schema = CartItemSchema(many=True)
product_schema = ProductSchema()



def create(cart_data):
    try:
        error, status_code = Cart.create(cart_data['user_id']).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response({'message': 'Cart successfully created'}, status_code)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def add_item(user_id, cart_data):
    try:
        found_cart, error, status_code = Cart.get_by_user(user_id).values()
        if error:
            return make_response({'error': error}, status_code)

        # Retrieve product by code
        found_product, product_error, product_status_code = Product.get_one(cart_data['code']).values()
        if product_error:
            return make_response({'error': product_error}, product_status_code)

        product = product_schema.dump(found_product)
        cart = cart_schema.dump(found_cart)
        created_cart_item, error, status_code = CartItem.create(cart['id'], product['id']).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response({'message': 'Product successfully added to cart'}, status_code)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def get_all():
    try:
        found_carts, error, status_code = Cart.get_all().values()
        if error:
            return make_response({'error': error}, status_code)

        carts_data = carts_schema.dump(found_carts)
        return make_response({'carts': carts_data}, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_one(cart_id):
    try:
        found_cart, error, status_code = Cart.get_one(cart_id).values()
        if error:
            return make_response({'error': error}, status_code)

        cart_data = cart_schema.dump(found_cart)
        return make_response({'cart': cart_data}, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_by_user(user_id):
    try:
        found_cart_items, error, status_code = Cart.get_items_by_user(user_id).values()
        if error:
            return make_response({'error': error}, status_code)

        cart_data = carts_item_schema.dump(found_cart_items)
        return make_response({'items': cart_data}, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def remove_item(user_id, cart_item_data):
    try:
        if 'cart_item_id' not in cart_item_data:
            return make_response({'error': 'cart_item_id is required'}, 400)

        found_cart, error, status_code = Cart.get_by_user(user_id).values()
        if error:
            return make_response({'error': error}, status_code)

        cart_data = cart_schema.dump(found_cart)
        error, status_code = CartItem.delete(cart_data['id'], cart_item_data['cart_item_id']).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response('', status_code)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 404)
