from flask import request, abort
from flask_restplus import Namespace, Resource, fields, reqparse
from database.database import Database
from database.swagger_models import food
from database.marshmallow_models import NewFoodSchema, FoodSchema, ObjectIdField, Ingredients
from marshmallow import Schema

from apis.id_exchange import correct_id

import requests


api = Namespace('food',description='Operations related to the food components')

#swagger schemas
food = api.schema_model('Food', food)

#get all foods
@api.route('/')
class foodList(Resource):
    @api.doc(description='Get all food', responses={200: ('food collection', [food])})
    def get(self):
        allfoods = [{**fl, '_id': str(fl['_id'])} for fl in Database().Get_Foods()]
        allfoods = correct_id(allfoods)
        return allfoods
    
#get food by id
@api.route('/<string:food_id>')
@api.param('food_id','food identifier')
class FoodById(Resource):
    @api.doc(description='Returns a food item',
             responses={200: ('Returned food item', food),
                        404: 'Food item not found'})
    def get(self, food_id):
        food = [{**fd, '_id': str(fd['_id'])} for fd in Database().Get_Food(food_id)][0]
        return food

#get food by type
@api.route('/type/<int:food_type>')
@api.param('food_type','The type of the food')
class FoodByType(Resource):
    @api.doc(description='Returns all the food items that share the same type',
             responses={200: ('Food by type collection', [food])})
    def get(self, food_type):
        foodByType = [{**fbt, '_id':str(fbt['_id'])} for fbt in Database().Get_Food_Type(food_type)]
        return FoodByType

#add a food item
@api.route('/add')
@api.expect(food)
class AddFood(Resource):
    @api.doc(description='Adds a food item to the database',
             responses={201: 'food added succesfully',
                        404: 'error adding food'})
    def post(self):
        doit = False
        new_foods, errors = NewFoodSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message': 400}
        if new_foods:
            doit = Database().Add_Food(new_foods)
        return { 'message': ('Food added') if (not errors and doit) else
                ("The food wasn't added, maybe duplicate a name")}, 200 if (new_foods and doit) else 404

#update a food item
@api.route('/update/<string:food_id>')
@api.expect(food)
class UpdateFood(Resource):
    @api.doc(description='Updates food item',
             responses={201: 'Food updated',
                        404: 'Error updating food'})
    def put(self,food_id):
        doit = False
        update_food, errors = NewFoodSchema().load(request.get_json(force=True) or {})
        if errors:
            return {'message':400}
        if update_food:
            doit = Database().Update_Food(food_id,update_food)
        return {'message': ('food updated') if(not errors and doit) else
                ('No matching food to update')}, 200 if (update_food and doit) else 404

@api.route('/delete/<string:food_id>')
class DeleteFood(Resource):
    @api.doc(description='Delete the food item',
             responses= {200: 'Food deleted',
                         400: 'Error deleting'})
    def post(self,food_id):
        response = False
        response = Database().Delete_Food(food_id)
        if response:
            return {'message': 'Food Deleted'}, 200
        else:
            return {'meesage': 'Error No Matching Food'}, 400