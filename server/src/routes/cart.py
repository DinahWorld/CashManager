from flask import Blueprint, request
from src.services.cart import create, get_all, get_one, get_by_user, add_item, remove_item
from flask_login import login_required, current_user
cart_route = Blueprint('cart_route', __name__)


@cart_route.route("/api/carts", methods=['POST'])
@login_required
def create_cart():
    return create({"user_id": current_user.user_json['id']})


@cart_route.route("/api/carts", methods=['GET'])
@login_required
def get_carts():
    carts = get_all()
    return carts


@cart_route.route("/api/carts/<cart_id>", methods=['GET'])
@login_required
def cart_detail(cart_id):
    cart = get_one(cart_id)
    return cart


@cart_route.route("/api/carts/my", methods=['GET'])
@login_required
def get_cart_by_user():
    cart = get_by_user(current_user.user_json['id'])
    return cart


@cart_route.route("/api/carts/my", methods=['POST'])
@login_required
def add_cart_item():
    data = request.get_json()
    return add_item(current_user.user_json['id'], data)


@cart_route.route("/api/carts/my", methods=['DELETE'])
@login_required
def remove_cart_item():
    data = request.get_json()
    return remove_item(current_user.user_json['id'], data)
