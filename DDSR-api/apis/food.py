from flask import request
from flask_restplus import Namespace, Resource, fields

api = Namespace('food',description='Operations related to the food components')

food = api.schema_model('Food', {
    'type': 'object',
    'properties': {
        'id': {
            'type': 'string',
            'description': 'The id of the food item',
            'example': 1
        },
        'name': {
            'type': 'string',
            'description': 'The name of the food item',
            'example': 'arroz de coco',
        },
        'cost': {
            'type': 'number',
            'description': 'The price of the food item',
            'example': 2500
        },
        'type': {
            'type': 'number',
            'description': 'Type of the food item, sweet or salty',
            'example': 1,
        }
        
    }
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
class foodList(Resource):
    @api.doc('food_list')
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
        

