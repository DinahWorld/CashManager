import stripe
from flask import make_response
from src.models.user import User
from collections import OrderedDict


def create_payment_intent(data):
    try:
        print(data['amount'])
        payment_intent = stripe.PaymentIntent.create(
            amount=data['amount'],
            currency='eur',
            payment_method_types=['card'],
        )
        return make_response({'payment_intent_id': payment_intent['id']}, 200)
    except KeyError as e:
        return make_response({'error': f'{str(e)} is required'}, 400)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def create_customer(data):
    try:
        customer = stripe.Customer.create(email=data['email'])
        return OrderedDict(customer=customer, error=None, status=200)
    except KeyError as e:
        return OrderedDict(customer=None, error=f'{str(e)} is required', status=400)
    except Exception as e:
        return OrderedDict(customer=None, error=str(e), status=500)


def create_payment_method(user_id, data):
    try:
        payment_method = stripe.PaymentMethod.create(
            type='card',
            card={
                'number': data['card_number'],
                'exp_month': data['exp_month'],
                'exp_year': data['exp_year'],
                'cvc': data['cvc'],
            },
        )

        # Store payment method in user
        updated_user, error, status_code = User.update_by_id(user_id, {'payment_method_id': payment_method['id']}).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response({'payment_method': payment_method}, 200)
    except KeyError as e:
        return make_response({'error': f'{str(e)} is required'}, 400)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def confirm_payment_intent(payment_method_id, data):
    try:
        payment_intent = stripe.PaymentIntent.confirm(
            data['payment_intent_id'],
            payment_method=payment_method_id,
        )
        return make_response({'message': 'Payment intent confirmed', 'payment_intent': payment_intent}, 200)
    except KeyError as e:
        return make_response({'error': f'{str(e)} is required'}, 400)
    except Exception as e:
        return make_response({'error': str(e)}, 500)