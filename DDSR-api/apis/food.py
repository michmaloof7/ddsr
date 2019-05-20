from flask import request
from flask_restplus import Namespace, Resource, fields
from database.database import Database
from database.swagger_models import food


api = Namespace('food',description='Operations related to the food components')

#swagger schemas
food = api.schema_model('Food', food)


#get all foods
@api.route('/')
class foodList(Resource):
    @api.doc(summary='Get all foods', description='Get all food',responses={200: ('food collection', [food])})
    def get(self):
        return [food for foods in Database().get_foods()]
    
#get food by id
@api.route('/<string:food_id>')
@api.param('food_id', description='Food identifier', required=True, type='string')
@api.response('404', 'Food not found')
class FoodById(Resource):
    @api.doc(summary='get food by id',description='Returns a food item',
             responses={200: ('Returned food item', food),
                        404: 'Food item not found'})
    def get(self, food_id):
        return [{**fd, '_id': str(fd['_id'])}
                for fd in Database().get_food(food_id)][0]
