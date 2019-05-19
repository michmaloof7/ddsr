from flask import Flask
from flask_restplus import Namespace, Resource, fields
from datetime import date, datetime

api = Namespace('Orders', description="Api endpoints for order related operations")

#food item model
food = api.model('Food', {
    'id': fields.String(description='The id of the food item'),
    'name': fields.String(required=True,description='The name of the food item'),
    'cost': fields.Integer(required=True,description='The cost of the food item'),
    'type': fields.Integer(required=True,description='The type of the food, salty or sweet')
})

#order model
order = api.model('Orders', {
    'id': fields.String(description='The id of the order'),
    'client_id': fields.String(required=True,description='The client that made the order'),
    'deadline': fields.DateTime(required=True,description='The deadline of the order'),
    'items': fields.List(fields.Nested(food),required=True,description='The food included in the order'),
    'status': fields.Integer(required=True,default=0,description='The status of the order')
})


DEFAULT_ORDER = [{'id':'a12343211', 
                'client_id':'Luis Fernandez',
                'deadline': '2019-07-03',
                'items': [{
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
                'status': 1
                },
            ]

@api.route('/')
class ordertList(Resource):
    @api.doc('order_list')
    @api.marshal_list_with(order)
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
            
