from src.database.schema import ma


class OrderSchema(ma.Schema):
    class Meta:
        fields = ('user_id', 'id', 'payment_intent_id', 'price', 'created_at')
