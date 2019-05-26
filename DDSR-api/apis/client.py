from flask import request, abort
from flask_restplus import Namespace, Resource, fields, reqparse
from database.database import Database
from database.swagger_models import client
from database.marshmallow_models import NewClientSchema, ClientSchema, ObjectIdField, Address
from marshmallow import Schema

from apis.id_exchange import correct_id

import requests

api = Namespace('Client',description="Api endpoints for client related operations")

#importing swagger schemas
client = api.schema_model('Client', client)

#get all clients
@api.route('/')
class clientList(Resource):
    @api.doc(description='Get all clients', responses={200: ('client collection', [client])})
    def get(self):
        allclients = [{**cl, '_id': str(cl['_id'])} for cl in Database().Get_Clients()]
        allclients = correct_id(allclients)
        return allclients

#get a client by its id
@api.route('/<string:client_id>')
@api.param('client_id', 'Client identifier')
class clientById(Resource):
    @api.doc(description='get client by id',
             responses={200: ('fetched client', client),
                        404: 'Client not found'})
    def get(self, client_id):
        client = [{**cbi, '_id': str(cbi['_id'])} for cbi in Database().Get_Client(client_id)][0] 
        return  client

#add a client 
@api.route('/add')
@api.expect(client)
class AddClient(Resource):
    @api.doc(description='Adds a Client to the database',
             responses={201: 'client added succesfully',
                        400: 'error adding client'})
    def post(self):
        doit = False
        new_client, errors = NewClientSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message': 400}
        if new_client:
            doit = Database().Add_Client(new_client)
        return { 'message': ('Client added') if (not errors and doit) else
                ("The client wasn't added, maybe a duplicate name")}, 201 if (new_client and doit) else 400

#update a food item
@api.route('/update/<string:client_id>')
@api.expect(client)
class UpdateClient(Resource):
    @api.doc(description='Updates a client',
             responses={201: 'Client updated',
                        404: 'Error updating client'})
    def put(self,food_id):
        doit = False
        update_client, errors = NewClientSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message':404}
        
        if update_client:
            doit = Database().Update_Client(client_id,update_client)

        return {'message': ('client updated') if(not errors and doit) else
                ('No matching client to update')}, 200 if (update_client and doit) else 404

@api.route('/delete/<string:client_id>')
class DeleteClient(Resource):
    @api.doc(description='Delete a client from database',
             responses= {200: 'Client deleted',
                         404: 'Error deleting'})
    def post(self,client_id):
        response = False
        response = Database().Delete_Client(client_id)
        if response:
            return {'message': 'Client Deleted'}, 200
        else:
            return {'meesage': 'Error No Matching Client'}, 404