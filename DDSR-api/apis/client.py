from flask import Flask
from flask_restplus import Namespace, Resource, fields

api = Namespace('Client',description="Api endpoints for client related operations")

address = api.model('Address', {
    'city': fields.String(description='The city of the client'),
    'street_address': fields.String(description='The neighborhood of the client')
})


client = api.model('Client', {
    'id': fields.String(description='The id of the client'),
    'name': fields.String(required=True,description='The name of the client'),
    'phone': fields.Integer(required=True,description='The phone number of the client'),
    'full_address': fields.List(fields.Nested(address),required=True,description='The address of the client')

})


DEFAULT_CLIENT = [{'id':'a1234321', 
                'name':'Luis Fernandez',
                'phone': 1111111,
                'address': {
                    'street_address': 'Centro',
                    'city': 'Cartagena de Indias'
                    }
                },
                {
                'id':'a2343212132', 
                'name':'Pablo Martinez',
                'phone': 1111112,
                'address': {
                   'city': 'Cartagena de Indias',
                   'street_address': 'La princesa'
                    }
                }]

@api.route('/')
class clientList(Resource):
    @api.doc('client_list')
    def get(self):
        return DEFAULT_CLIENT

@api.route('/<id>')
@api.param('id', 'Client identifier')
@api.response('404', 'client not found')
class clientById(Resource):
    @api.doc('get client by id')
    @api.marshal_with(client,envelope='resource')
    def get(self, id):
        try:
            for client in DEFAULT_CLIENT:
                if client['id'] == id:
                    return client
        except:
            api.abort(404)
            
