from marshmallow import Schema, fields, ValidationError
from bson import ObjectId
from bson.objectid import InvalidId


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

class FoodSchema(Schema):
    _id = ObjectIdField(required=True)
    name = fields.Str(required=True)
    cost = fields.Integer(required=True)
    type = fields.Integer(required=True)


class NewFoodSchema(Schema):
    name = fields.Str(required=True)
    cost = fields.Integer(required=True)
    type = fields.Integer(required=True)