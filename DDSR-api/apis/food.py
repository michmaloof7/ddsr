from flask import request
from flask_restplus import Namespace, Resource, fields

api = Namespace('food',description='Operations related to the food components')


food = api.model('Food', {
    'id': fields.String(description='The id of the food item'),
    'name': fields.String(required=True,description='The name of the food item'),
    'cost': fields.Integer(required=True,description='The cost of the food item'),
    'type': fields.Integer(required=True,description='The type of the food, salty or sweet')
})

DEFAULT_FOOD = [{'id':'a123432', 
                'name':'Arroz de coco',
                'cost': 200,
                'type': 1},
                {
                'id':'a2343212', 
                'name':'Arroz blanco',
                'cost': 100,
                'type': 1
                }]

@api.route('/')
class foodList(Resource):
    @api.doc('food_list')
    @api.marshal_with(food,envelope='resource')
    def get(self):
        return DEFAULT_FOOD
    
@api.route('/<id>')
@api.param('id', 'Food identifier')
@api.response('404', 'Food not found')
class foodById(Resource):
    @api.doc('get_food_by_id')
    def get(self, id):
        try:
            for food in DEFAULT_FOOD:
                if food['id'] == id:
                    return food
        except:
            api.abort(404)
        

