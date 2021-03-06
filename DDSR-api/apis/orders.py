from flask import Flask, request
from flask_restplus import Namespace, Resource, fields, reqparse
from database.swagger_models import food, order, client
from database.marshmallow_models import NewOrderSchema, OrderSchema, FoodSchema, ClientSchema
from database.database import Database
import requests

api = Namespace('Orders', description="Api endpoints for order related operations")

#importing swagger schemas
order = api.schema_model('Order', order)
food = api.schema_model('Food', food)
client = api.schema_model('Client', client)


#get all the orders
@api.route('/')
class orderList(Resource):
    @api.doc(description='orders list', responses={200: ('Order collection', [order])})
    def get(self):
        return [{**od, '_id': str(od['_id'])}
                for od in Database().Get_Orders()]

#get an order by its id
@api.route('/<string:order_id>')
@api.param('order_id', 'Order identifier')
class clientById(Resource):
    @api.doc(description='Return a single order by its id', 
             responses={200: ('Returned order', order),
                        404: 'Food item not found'})
    def get(self, order_id):
        return [{**odi, '_id': str(odi['_id'])}
                for odi in Database().Get_Order(order_id)]
            
#add an order
@api.route('/add')
@api.expect(order)
class AddOrder(Resource):
    @api.doc(description="Add a new order",
            responses={200: 'Added a new order',
                       400: "Couldn't add the order"})
    def post(self):
        doit = False
        new_order, errors = NewOrderSchema.load(request,get_json(force=True) or {})
        if errors:
            return {'message':400}
        if new_order:
            Database().Add_Order(new_order)
        return { 'message': ('Order added') if (not errors and doit) else
                ("The Order wasn't added")}, 201 if (new_client and doit) else 400
    
#update a food item
@api.route('/update/<string:order_id>')
@api.expect(order)
class UpdateOrder(Resource):
    @api.doc(description='Updates an order',
             responses={201: 'order updated',
                        404: 'Error updating order'})
    def put(self,order_id):
        doit = False
        update_order, errors = NewOrderSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message':404}
        
        if update_order:
            doit = Database().Update_Order(order_id,update_order)

        return {'message': ('order updated') if(not errors and doit) else
                ('No matching order to update')}, 200 if (update_order and doit) else 404

@api.route('/delete/<string:order_id>')
class DeleteOrder(Resource):
    @api.doc(description='Delete an order from database',
             responses= {200: 'order deleted',
                         404: 'Error deleting'})
    def post(self,order_id):
        response = False
        response = Database().Delete_Order(order_id)
        if response:
            return {'message': 'Order Deleted'}, 200
        else:
            return {'meesage': 'Error No Matching Order to delete'}, 404
