
# ----- Model definitions in JSON format -----

food = {
    'type': 'object',
    'properties': {
        '_id': {
            'type': 'string',
            'description': 'Unique food identifier'
        },
        'name': {
            'type': 'string',
            'description': 'Food name',
            'example': 'pie de manzana'
        },
        'cost': {
            'type': 'number',
            'description': 'The cost of the food',
            'example': '$6000'
        },
        'type': {
            'type': 'number',
            'description': 'The type of the food',
            'example': 1
        }
    }
}

address = {
    'type': 'object',
    'properties': {
        'city': {
            'type': 'string',
            'description': 'The city where the client resides'
        },
        'street_address': {
            'type': 'string',
            'description': 'The full adress of the client',
            'example': 'Bocagrande, calle 3, carrera 1'
        }
    }
}

client = {
    'type': 'object',
    'properties': {
        '_id': {
        'type': 'string',
        'description': 'Unique client identifier'
        },
        'name': {
            'type': 'string',
            'description': 'The name of the client',
            'example': 'Manuel Santana'
        },
        'phone': {
            'type': 'number',
            'description': 'The phone number of the client',
            'example': 31024417
        },
        'address': {
            'type': 'array',
            'items': {
                '$ref': '#/definitions/Address'
            }
        }
    }
}

order = {
    'type': 'object',
    'properties': {
        '_id': {
            'type': 'string',
            'description': 'Unique order identifier'
        },
        'client_id': {
            'type': 'string',
            'description': 'Unique client identifier'
        },
        'deadline': {
            'type': 'string',
            'description': 'The deadline of the order',
            'example': '2019-05-19T22:07:41.000+00:00'
        },
        'items': {
            'type': 'array',
            'items': {
                '$ref': '#/definitions/Food'
            }
        },
        'status': {
            'type': 'number',
            'description': 'The state of the order, completed, received, etc',
            'example': 0
        }
    }
}