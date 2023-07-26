from src.database.schema import ma


class OrderItemSchema(ma.Schema):
    class Meta:
        fields = ('order_item_id', 'order_id', 'product_id', 'product_name', 'product_code', 'product_price')
