from src.database.schema import ma


class ProductSchema(ma.Schema):
    class Meta:
        fields = ('code', 'name', 'price', 'id', 'is_buyable')
