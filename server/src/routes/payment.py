from flask import Blueprint, request
from src.services.stripe import create_payment_intent, create_payment_method, confirm_payment_intent
from flask_login import login_required, current_user
payment_route = Blueprint('payment_route', __name__)


@payment_route.route("/api/payment/intent", methods=['POST'])
@login_required
def create_intent():
    data = request.get_json()
    return create_payment_intent(data)


@payment_route.route("/api/payment/method", methods=['POST'])
@login_required
def create_method():
    data = request.get_json()
    return create_payment_method(current_user.user_json['id'], data)


@payment_route.route("/api/payment/confirm", methods=['POST'])
@login_required
def confirm_intent():
    data = request.get_json()
    print(current_user.user_json)
    return confirm_payment_intent(current_user.user_json['payment_method_id'], data)
