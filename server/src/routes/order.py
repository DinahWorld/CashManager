from flask import Blueprint, request
from src.services.order import create, get_all, get_one, get_list
from flask_login import login_required, current_user
order_route = Blueprint('order_route', __name__)


@order_route.route("/api/orders", methods=['POST'])
@login_required
def create_order():
    data = request.get_json()
    return create(current_user.user_json['id'], data)


@order_route.route("/api/orders", methods=['GET'])
@login_required
def get_orders():
    orders = get_all()
    return orders


@order_route.route("/api/orders/<order_id>", methods=['GET'])
@login_required
def order_detail(order_id):
    order = get_one(current_user.user_json['id'], order_id)
    return order


@order_route.route("/api/orders/list", methods=['GET'])
@login_required
def order_list():
    return get_list(current_user.user_json['id'])
