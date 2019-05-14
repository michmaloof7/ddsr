from flask import Blueprint
from flask_restplus import Api
from apis.food import api as food

blueprint = Blueprint('api', __name__, url_prefix='/mongoDDSR')

api = Api(blueprint, title='API REST', version='1.0.0',
          description='API for orders repository')

api.add_namespace(food, path='/foods')