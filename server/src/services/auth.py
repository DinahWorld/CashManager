from flask import make_response
from src.models.user import User
import bcrypt
import jwt
from src.schemas.user import UserSchema
from datetime import datetime, timezone, timedelta

user_schema = UserSchema()


def auth(params):
    try:
        found_user, error, status_code = User.get_by_email(params['email']).values()
        if error:
            return make_response({'error': error}, status_code)

        user = user_schema.dump(found_user)
        if bcrypt.checkpw(params['password'].encode('utf-8'), (user['password']).encode('utf-8')):
            token = jwt.encode(
                {
                    'role': 'admin',
                    'sub': user['email'],
                    'exp': datetime.now(timezone.utc) + timedelta(hours=2)
                },
                "secret",
                algorithm="HS256"
            )
            return make_response({
                'message': 'Authentication successful!',
                'token': token
            })
        else:
            return make_response({'error': 'Wrong password'}, 400)
    except KeyError as ke:
        return make_response({'error': f'Key missing : {str(ke)}'}, 400)
    except AttributeError as a:
        return make_response({'error': 'please provide a username and password as JSON in the request body'}, 400)
