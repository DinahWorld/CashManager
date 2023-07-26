from src.models import User, Cart
from flask import make_response
from src.schemas.user import UserSchema
from src.services.stripe import create_customer

user_schema = UserSchema()
users_schema = UserSchema(many=True)


def create(user_data):
    try:
        # Create customer in Stripe
        customer, error, status_code = create_customer(user_data).values()

        # Create user in database
        created_user, error, status_code = User.create(
            username=user_data['username'],
            email=user_data['email'],
            customer_id=customer['id'],
            password=user_data['password']).values()
        if error:
            return make_response({'error': error}, status_code)

        user = user_schema.dump(created_user)

        # Create unique Cart for user
        error, status_code = Cart.create(user['id']).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response({'message': 'Account successfully created'}, status_code)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_all():
    try:
        found_users, error, status = User.get_all().values()
        if error:
            return make_response({'error': error}, status)

        users = users_schema.dump(found_users)
        return make_response(users, status)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_by_id(user_id):
    try:
        found_user, error, status = User.get_by_id(user_id).values()
        if error:
            return make_response({'error': error}, status)

        user = user_schema.dump(found_user)
        return make_response(user, status)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_by_username(username):
    try:
        found_user, error, status = User.get_by_username(username).values()
        if error:
            return make_response({'error': error}, status)

        user = user_schema.dump(found_user)
        return make_response(user, status)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_by_email(email):
    try:
        found_user, error, status_code = User.get_by_email(email).values()
        if error:
            return make_response({'error': error}, status_code)

        user = user_schema.dump(found_user)
        return make_response(user, status_code)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def get_balance_by_user(user_id):
    try:
        found_user, error, status = User.get_by_id(user_id).values()
        if error:
            return make_response({'error': error}, status)

        user = user_schema.dump(found_user)
        return make_response({'balance': user['balance']}, status)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def add_to_balance(user_id, data):
    try:
        found_user, found_error, found_status_code = User.get_by_id(user_id).values()
        if found_error:
            return make_response({'error': found_error}, found_status_code)

        user = user_schema.dump(found_user)
        # Check if email is correct
        if user['email'] != data['email']:
            return make_response({'error': "Email doesn't correspond"}, 400)
        # Add to balance
        new_balance = user['balance'] + data['amount']
        updated_user, updated_error, updated_status = User.update_by_id(user_id, {'balance': new_balance}).values()
        if updated_error:
            return make_response({'error': updated_error}, updated_status)

        user = user_schema.dump(updated_user)
        return make_response({'message': 'Amount increased!', 'user': user}, updated_status)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def subtract_from_balance(user_id, data):
    try:
        found_user, found_error, found_status_code = User.get_by_id(user_id).values()
        if found_error:
            return make_response({'error': found_error}, found_status_code)

        user = user_schema.dump(found_user)
        # Check if email is correct
        if user['email'] != data['email']:
            return make_response({'error': "Email doesn't correspond"}, 400)
        # Substitute from balance
        new_balance = user['balance'] - data['amount']
        updated_user, updated_error, updated_status = User.update_by_id(user_id, {'balance': new_balance}).values()
        if updated_error:
            return make_response({'error': updated_error}, updated_status)

        user = user_schema.dump(updated_user)
        return make_response({'message': 'Amount decreased!', 'user': user}, updated_status)
    except KeyError as ke:
        return make_response({'error': 'Key not found : ' + str(ke)}, 404)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def update_by_id(user_id, user_data):
    try:
        updated_user, error, status_code = User.update_by_id(user_id, user_data).values()
        if error:
            return make_response({'error': error}, status_code)

        user = user_schema.dump(updated_user)
        return make_response(user, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 500)


def delete_by_id(user_id):
    try:
        error, status_code = User.delete_by_id(user_id).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response('', status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)
