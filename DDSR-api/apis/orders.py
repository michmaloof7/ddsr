from flask import Flask
from flask_restplus import Namespace, Resource, fields
from database.swagger_models import food, order, client

api = Namespace('Orders', description="Api endpoints for order related operations")

#importing swagger schemas
order = api.schema_model('Order', order)
food = api.schema_model('Food', food)
client = api.schema_model('Client', client)



@api.route('/')
class ordertList(Resource):
    @api.doc(description='orders list', responses={200: ('Order collection', [order])})
    def get(self):
        return []

@api.route('/<order_id>')
@api.param('order_id', 'Order identifier')
class clientById(Resource):
    @api.doc(description='Return a single order by its id', 
             responses={200: ('Returned food item', food),
                        404: 'Food item not found'})
    def get(self, order_id):
        return []
            
