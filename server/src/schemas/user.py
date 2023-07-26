from src.database.schema import ma


class UserSchema(ma.Schema):
    class Meta:
        fields = ('password', 'username', 'id', 'email', 'balance', 'customer_id', 'payment_method_id')
