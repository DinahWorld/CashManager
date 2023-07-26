from flask import Blueprint, request
from flask_login import login_required, current_user
from src.services.user import \
    create, \
    get_all, \
    get_by_id, \
    update_by_id, \
    delete_by_id, \
    get_by_username, \
    get_balance_by_user, \
    add_to_balance, \
    subtract_from_balance
user_route = Blueprint('user_route', __name__)


@user_route.route("/api/users", methods=['POST'])
def create_user():
    data = request.get_json()
    return create(data)


@user_route.route("/api/users", methods=['GET'])
@login_required
def get_users():
    users = get_all()
    return users


@user_route.route("/api/users/me", methods=['GET'])
@login_required
def get_user():
    user = get_by_id(current_user.user_json['id'])
    return user


@user_route.route("/api/users/<username>", methods=['GET'])
@login_required
def get_username(username):
    user = get_by_username(username)
    return user


@user_route.route("/api/users/me/balance", methods=['GET'])
@login_required
def get_balance():
    balance = get_balance_by_user(current_user.user_json['id'])
    return balance


@user_route.route("/api/users/me/balance/add", methods=['PATCH'])
@login_required
def add_balance():
    data = request.get_json()
    balance = add_to_balance(current_user.user_json['id'], data)
    return balance


@user_route.route("/api/users/me/balance/substract", methods=['PATCH'])
@login_required
def subtract_balance():
    data = request.get_json()
    balance = subtract_from_balance(current_user.user_json['id'], data)
    return balance


@user_route.route("/api/users/me", methods=['PATCH'])
@login_required
def update_user():
    user_data = request.get_json()
    updated = update_by_id(current_user.user_json['id'], user_data)
    return updated


@user_route.route("/api/users/me", methods=['DELETE'])
@login_required
def delete_user():
    deleted = delete_by_id(current_user.user_json['id'])
    return deleted
