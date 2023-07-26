from src.models.product import Product
from src.schemas.product import ProductSchema
from flask import make_response


product_schema = ProductSchema()
products_schema = ProductSchema(many=True)


def create(product_data):
    try:
        error, status_code = Product.create(
            code=product_data['code'],
            name=product_data['name'],
            price=product_data['price'],
            is_buyable=product_data['is_buyable']).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response({'message': 'Product successfully created'}, status_code)
    except KeyError as e:
        return make_response({'error': f'{str(e)} is required'}, 400)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_all():
    try:
        found_products, error, status_code = Product.get_all().values()
        if error:
            return make_response({'error': error}, status_code)

        products = products_schema.dump(found_products)
        return make_response(products, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def get_one(code):
    try:
        found_product, error, status_code = Product.get_one(code).values()
        if error:
            return make_response({'error': error}, status_code)

        product = product_schema.dump(found_product)
        return make_response(product, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)


def update_one(product_id, product_data):
    try:
        updated_product, error, status_code = Product.update_one(product_id, product_data).values()
        if error:
            return make_response({'error': error}, status_code)

        product = product_schema.dump(updated_product)
        return make_response(product, status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)

def delete_one(product_id):
    try:
        error, status_code = Product.delete_one(product_id).values()
        if error:
            return make_response({'error': error}, status_code)

        return make_response('', status_code)
    except Exception as e:
        return make_response({'error': str(e)}, 404)
