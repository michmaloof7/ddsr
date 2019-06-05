from marshmallow import Schema, fields, ValidationError
from bson import ObjectId
from bson.objectid import InvalidId
from dateutil import parser
from datetime import datetime

#validating the ID field
class ObjectIdField(fields.Field):
    default_error_message = {
        'invalid': 'Invalid ID'
    }
    def _deserialize(self,value,attr,data):
        try:
            return ObjectId(value)
        except InvalidId:
            raise ValidationError("Invalid ID")
        return ObjectId(value)

#ingredients fields
class Ingredients(fields.Field):
    name = fields.Str(required=True)
    unit = fields.Str(required=True)
    quantity = fields.Integer(required=True)

#address fields
class Address(fields.Field):
    city = fields.Str(required=True)
    street_address = fields.Str(required=True)

#date field
class DateField(fields.Field):
    default_error_message = {
        'invalid': 'Invalid date'
    }
    def _deserialize(self, value, attr, data):
        if type(value) != str:
            raise ValidationError("Field is not a string")
        try:
            if value:
                return parser.parse(value)
            return datetime.now()

        except ValueError:
            raise ValidationError("The String doesn't have a valid ISO format for date.")



#full food schema
class FoodSchema(Schema):
    _id = ObjectIdField(required=True)
    name = fields.Str(required=True)
    cost = fields.Integer(required=True)
    type = fields.Integer(required=True)
    ingredients = fields.List(Ingredients(),allow_none=True)

#schema for creating food
class NewFoodSchema(Schema):
    name = fields.Str(required=True)
    cost = fields.Integer(required=True)
    type = fields.Integer(required=True)
    ingredients = fields.List(Ingredients(),allow_none=True)

#schema for client
class ClientSchema(Schema):
    _id = ObjectIdField(required=True)
    name = fields.Str(required=True)
    phone = fields.Integer(required=True)
    address = Address(allow_none=True)

#schema for new clients
class NewClientSchema(Schema):
    name = fields.Str(required=True)
    phone = fields.Integer(required=True)
    address = Address(allow_none=True)

class FoodFields(fields.Field):
    _id = ObjectIdField(required=True)
    name = fields.Str(required=True)
    cost = fields.Integer(required=True)
    type = fields.Integer(required=True)
    ingredients = fields.List(Ingredients(),allow_none=True)


#schema for orders
class OrderSchema(Schema):
    _id = ObjectIdField(required=True)
    client_id = ObjectIdField(required=True)
    deadline = DateField(required=True)
    items = fields.List(FoodFields(), required=True)
    status = fields.Integer(required=True)

#schema for new orders
class NewOrderSchema(Schema):
    client_id = ObjectIdField(required=True)
    deadline = DateField(required=True)
    items = fields.List(FoodFields(), required=True)
    status = fields.Integer(required=True)