from flask import Blueprint, request
from src.services.product import create, get_all, get_one, update_one, delete_one
from flask_login import login_required
product_route = Blueprint('product_route', __name__)


@product_route.route("/api/products", methods=['POST'])
@login_required
def create_product():
    data = request.get_json()
    return create(data)


@product_route.route("/api/products", methods=['GET'])
@login_required
def get_products():
    products = get_all()
    return products


@product_route.route("/api/products/<product_id>", methods=['GET'])
@login_required
def product_detail(product_id):
    product = get_one(product_id)
    return product


@product_route.route("/api/products/<product_id>", methods=['PATCH'])
@login_required
def update_product(product_id):
    data = request.get_json()
    return update_one(product_id, data)


@product_route.route("/api/products/<product_id>", methods=['DELETE'])
@login_required
def delete_product(product_id):
    return delete_one(product_id)
