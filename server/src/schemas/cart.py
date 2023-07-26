from src.database.schema import ma


class CartSchema(ma.Schema):
    class Meta:
        fields = ('user_id', 'id')
