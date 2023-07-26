from flask import Blueprint, request
from src.services.auth import auth

auth_route = Blueprint('auth_route', __name__)


@auth_route.route("/api/auth/login", methods=['POST'])
def login():
    data = request.get_json()
    return auth(data)
