from src.models.order import Order
from src.models.cart import Cart
from src.models.order_item import OrderItem
from src.models.cart_item import CartItem
from flask import make_response
from src.schemas.order import OrderSchema
from src.schemas.cart import CartSchema
from src.schemas.cart_item import CartItemSchema
from src.schemas.order_item import OrderItemSchema

order_item_schema = OrderItemSchema()
order_items_schema = OrderItemSchema(many=True)
cart_item_schema = CartItemSchema()
cart_items_schema = CartItemSchema(many=True)
cart_schema = CartSchema()
carts_schema = CartSchema(many=True)
order_schema = OrderSchema()
orders_schema = OrderSchema(many=True)


def create(user_id, cart_data):
    try:
        # get all cart items from cart_id linked to user_id
        found_cart_items, error, cart_status_code = Cart.get_items_by_user(user_id).values()
        if error:
            return make_response({'error': error}, cart_status_code)

        cart_items = cart_items_schema.dump(found_cart_items)
        # Create order items
        created_order, error, order_status_code  = Order.create(user_id, cart_data['payment_intent_id'], cart_data['price']).values()
        if error:
            return make_response({'error': error}, order_status_code)

        order = order_schema.dump(created_order)
        # create order items by cart items
        for cart_item in cart_items:
            OrderItem.create({'order_id': order['id'], 'product_id' : cart_item['product_id']})

        # Delete cart items from cart_id linked to user_id
        for cart_item in cart_items:
            error, status_code = CartItem.delete(cart_item['cart_id'], cart_item['cart_item_id']).values()
            if error:
                return make_response({'error': error}, status_code)

        return make_response({'order': order}, order_status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_all():
    try:
        found_orders, error, status_code = Order.get_all().values()
        if error:
            return make_response({'error': error}, status_code)

        orders = orders_schema.dump(found_orders)
        return make_response({'orders': orders}, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_one(user_id, order_id):
    try:
        found_order_items, order_items_error, order_items_status_code = Order.get_by_user_and_order(user_id, order_id).values()
        if order_items_error:
            return make_response({'error': order_items_error}, order_items_status_code)

        # get order
        found_order, error, status_code = Order.get_by_id(order_id).values()
        if error:
            return make_response({'error': error}, status_code)

        order = order_schema.dump(found_order)
        items = order_items_schema.dump(found_order_items)
        return make_response({'order': order, 'items': items}, order_items_status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def get_list(user_id):
    try:
        found_orders, error, status_code = Order.get_by_user(user_id).values()
        if error:
            return make_response({'error': error}, status_code)

        orders = orders_schema.dump(found_orders)
        return make_response({'orders': orders}, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 500)
