import json
from src.models import User, Cart, Order, Product, CartItem, OrderItem


def create_dummy_user():
    is_created = create_dummy('src/dummies/dummy_user.json', User)
    if is_created:
        print('User dummies created')


def create_dummy_cart():
    is_created = create_dummy('src/dummies/dummy_cart.json', Cart)
    if is_created:
        print('Cart dummies created')


def create_dummy_order():
    is_created = create_dummy('src/dummies/dummy_order.json', Order)
    if is_created:
        print('Order dummies created')


def create_dummy_product():
    is_created = create_dummy('src/dummies/dummy_product.json', Product)
    if is_created:
        print('Product dummies created')


def create_dummy_cart_item():
    is_created = create_dummy('src/dummies/dummy_cart_item.json', CartItem)
    if is_created:
        print('Cart Item dummies created')


def create_dummy_order_item():
    is_created = create_dummy('src/dummies/dummy_order_item.json', OrderItem)
    if is_created:
        print('Order Item dummies created')


def create_dummy(file, model):
    f = open(file, 'r')
    dummies = json.load(f)
    for dummy in dummies['data']:
        is_created, message, status = model.create(dummy)
        if not is_created:
            print(message, status)
            return False
    f.close()
    return True
