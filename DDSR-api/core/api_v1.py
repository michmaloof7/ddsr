from flask import Blueprint
from flask_restplus import Api
from apis.food import api as food
from apis.client import api as client
from apis.orders import api as order

blueprint = Blueprint('api', __name__, url_prefix='/mongoDDSR')

api = Api(blueprint, title='API REST', version='1.0.0',
          description='API for orders repository')

api.add_namespace(food, path='/foods')
api.add_namespace(client, path='/clients')
api.add_namespace(order, path='/orders')

