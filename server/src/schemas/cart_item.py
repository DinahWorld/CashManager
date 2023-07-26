from src.database.schema import ma


class CartItemSchema(ma.Schema):
    class Meta:
        fields = ('cart_item_id', 'cart_id', 'product_id', 'product_name', 'product_code', 'product_price')
