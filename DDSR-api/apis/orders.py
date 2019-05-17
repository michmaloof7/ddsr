from flask import Flask
from flask_restplus import Namespace, Resource, fields
from datetime import date, datetime

api = Namespace('Orders', description="Api endpoints for order related operations")


order = client = food = api.schema_model('Order', {
    'type': 'object',
    'required': ['client','food'],
    'properties': {
        'id': {
            'type': 'string',
            'description': 'The id of the order',
            'example': 1
        },
        'client': {
            '$ref' : '#/definitions/client'
        },
        'deadline': {
            'type': 'string',
            'description': 'The deadline of the order',
            'format': 'date',
            'example': '2019-06-16'
        },
        'items': {
            'type': 'array',
            'description': 'The food items of the order',
            'items': {
                '$ref': '#/definitions/food'
            },
            'default': []
        },
        'delivered': {
            'type': 'number',
            'description': 'Status of the order',
            'example': 1
        }

    }
})

DEFAULT_ORDER = [{'id':'a12343211', 
                'client':'Luis Fernandez',
                'Deadline': '2019-07-03',
                'Items': [{
                    'id':'a123432', 
                    'name':'Arroz de coco',
                    'cost': 200,
                    'type': 1
                    },
                    {
                    'id':'a2343212', 
                    'name':'Arroz blanco',
                    'cost': 100,
                    'type': 1
                    }],
                'Delivered': 1
                },
            ]

@api.route('/order')
class ordertList(Resource):
    @api.doc('order_list')
    def get(self):
        return DEFAULT_ORDER

@api.route('/<id>')
@api.param('id', 'Order identifier')
@api.response('404', 'client not found')
class clientById(Resource):
    @api.doc('get order by id')
    @api.marshal_with(order,envelope='resource')
    def get(self, id):
        try:
            for order in DEFAULT_ORDER:
                if client['id'] == id:
                    return order
        except:
            api.abort(404)
            
