from flask import request, abort
from flask_restplus import Namespace, Resource, fields, reqparse
from database.database import Database
from database.swagger_models import food
from database.marshmallow_models import NewFoodSchema, FoodSchema
from marshmallow import Schema

import requests


api = Namespace('food',description='Operations related to the food components')

#swagger schemas
food = api.schema_model('Food', food)


#get all foods
@api.route('/')
class foodList(Resource):
    @api.doc(description='Get all food', responses={200: ('food collection', [food])})
    def get(self):
        return [{**fl, '_id': str(fl['_id'])}
                for fl in Database().get_foods()]
    
#get food by id
@api.route('/<string:food_id>')
@api.param('food_id','food identifier')
class FoodById(Resource):
    @api.doc(description='Returns a food item',
             responses={200: ('Returned food item', food),
                        404: 'Food item not found'})
    def get(self, food_id):
        return [{**fd, '_id': str(fd['_id'])}
                for fd in Database().get_food(food_id)][0]

#get food by type
@api.route('/type/<int:food_type>')
@api.param('food_type','The type of the food')
class FoodByType(Resource):
    @api.doc(description='Returns all the food items that share the same type',
             responses={200: ('Food by type collection', [food])})
    def get(self, food_type):
        return [{**fbt, '_id':str(fbt['_id'])}
                 for fbt in Database().get_food_type(food_type)]

#add a food item
@api.route('/add')
@api.expect(food)
class AddFood(Resource):
    @api.doc(description='Adds a food item to the database',
             responses={201: 'food added succesfully',
                        400: 'error adding food'})
    def post(self):
        new_foods, errors = NewFoodSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message': 400}
        if new_foods:
            check = Database().Add_Food(new_foods)
        return { 'message': ('Food added') if not errors or not check else
                ("The food wasn't added due to error")}, 200 if new_foods else 400

#update a food item
@api.route('/update/<string:food_id>')
@api.expect(food)
class UpdateFood(Resource):
    @api.doc(description='Updates food item',
             responses={201: 'Food updated',
                        400: 'Error updating food'})
    def put(self,food_id):
        update_food, errors = NewFoodSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message':400}
        if update_food:
            Database().Update_Food(food_id,update_food)
        return {'message': ('food updated') if not errors else
                ('The food wasnt updated')}, 200 if update_food else 400