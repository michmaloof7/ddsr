
# ----- Model definitions in JSON format -----

#The food table is made by a combination of ingredients

food = {
    'type': 'object',
    'required': ['name', 'cost', 'type'],
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
        },
        'ingredients': {
            'type': 'array',
            'description': 'Ingredients used to make this food',
            'example': '[manzanas, platano, azucar, harina]',
            'items': {
                'type': 'object',
                'description': 'Each ingredient of the food',
                'properties': {
                    'name': {
                        'type': 'string',
                        'description': 'The name of the ingredient',
                        'example': 'fresa'
                    },
                    'unit': {
                        'type': 'string',
                        'description': 'The measurement unit of this ingredient',
                        'example': 'liters, kilograms, pieces'
                    },
                    'quantity': {
                        'type': 'number',
                        'description': 'The measured quantity of this ingredient',
                        'example': '10 Unit, 1 Unit'
                    }
                }
            }
        }
    }
}

""" ---- DIDNT WANT TO BE REFFERENCED INTO CLIENTS
        SO I WILL BANISH IT TO THE SHADOW REALM ----
address = {
    'type': 'object',
    'properties': {
        'city': {
            'type': 'string',
            'description': 'The city where the client resides',
            'example': 'Cartagena'
        },
        'street_address': {
            'type': 'string',
            'description': 'The full adress of the client',
            'example': 'Bocagrande, calle 3, carrera 1'
        }
    }
}
"""

client = {
    'type': 'object',
    'required': ['name', 'phone'],
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
            'type': 'object',
            'properties': {
                'city': {
                'type': 'string',
                'description': 'The city where the client resides',
                'example': 'Cartagena'
                },
                'street_address': {
                'type': 'string',
                'description': 'The full adress of the client',
                'example': 'Bocagrande, calle 3, carrera 1'
                }
            }
        }
    }
}

order = {
    'type': 'object',
    'required': ['client_id', 'deadline', 'items','status'],
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