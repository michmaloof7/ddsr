from flask import Flask
from flask_restplus import Namespace, Resource, fields

api = Namespace('Client',description="Api endpoints for client related operations")

client = api.schema_model('Client', {
    'type': 'object',
    'properties': {
        'id': {
            'type': 'string',
            'description': 'The id of the client',
            'example': 1
        },
        'name': {
            'type': 'string',
            'description': 'The name of the client',
            'example': 'Gusano Gusanin de La Gusanera',
        },
        'phone': {
            'type': 'number',
            'description': 'The phone number of the client',
            'example': 3010000
        },
        'address': {
            'type': 'object',
            'properties': {
                'city': {
                    'type': 'string',
                    'description': 'The city of the client',
                    '   example': 'cartagena'
                },
                'street_address': {
                    'type': 'string',
                    'description': 'The neighborhood where the client resides',
                    'example': 'Centro, calle 14'  
                }
            }
        }

    }
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

@api.route('/client')
class clientList(Resource):
    @api.doc('client_list')
    def get(self):
        return DEFAULT_CLIENT

@api.route('/<id>')
@api.param('id', 'Client identifier')
@api.response('404', 'client not found')
class clientById(Resource):
    @api.doc('get client by id')
    def get(self, id):
        try:
            for client in DEFAULT_CLIENT:
                if client['id'] == id:
                    return client
        except:
            api.abort(404)
            
