from flask import Flask
from flask_restplus import Namespace, Resource, fields
from database.swagger_models import client

api = Namespace('Client',description="Api endpoints for client related operations")

#importing swagger schemas
client = api.schema_model('Client', client)

@api.route('/')
class clientList(Resource):
    @api.doc(description='Client list',
             responses={200: ('client colection', [client])})
    def get(self):
        return []

@api.route('/<client_id>')
@api.param('client_id', 'Client identifier')
class clientById(Resource):
    @api.doc(description='get client by id',
             responses={200: ('fetched client', client),
                        400: 'Client not found'})
    def get(self, client_id):
        return []    
