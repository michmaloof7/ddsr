from flask import request
from flask_restplus import Namespace, Resource, fields

api = Namespace('food',description='Operations related to the food components')

food = api.model('Food',{
    'id': fields.String(required=True, description='Food id'),
    'name': fields.String(required=True, description='The food name'),
    'cost': fields.Integer(required=True, description='Food cost'),
    'type': fields.Integer(required=True, description='Details of this food component')
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

@api.route('/food')
class FoodList(Resource):
    @api.doc('food_list')
    @api.marshal_list_with(food)
    def get(self):
        return DEFAULT_FOOD
    
@api.route('/<id>')
@api.param('id', 'Food identifier')
@api.response('404', 'Food not found')
class Food(Resource):
    @api.doc('get_food_by_id')
    @api.marshal_with(food)
    def get(self, id):
        try:
            for food in DEFAULT_FOOD:
                if food['id'] == id:
                    return food
        except:
            api.abort(404)
        

