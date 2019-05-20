import pymongo
import json
from bson.objectid import ObjectId



#class in charge of all the database transactions

class Database():

    _db_client = pymongo.MongoClient('mongodb://mongodb:27017/')
    #we set up the default database for our collections which is local
    _default_db = _db_client.local
    _instance = None

    def __init__(self):
        self.client = Database._default_db.client
        self.food = Database._default_db.food
        self.order = Database._default_db.order
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = object.__new__(cls)
        return cls._instance

    #-------- FOOD OPERATIONS -------#
    
    #get all foods
    def get_foods(self):
        return [food for food in self.food.find()]
    
    #get a food by id
    def get_food(self, id):
        return self.food.find({"_id": ObjectId(id)})

    #get a food by type
    def get_food_type(self, food_type):
        return [food for food in self.food.find({"type": food_type})]

    #add food
    def Add_Food(self, new_food):
        check = self.food.find_one({'name': new_food['name']})
        if check:
            return
        self.food.insert_one(new_food)

    #update food
    def Update_Food(self, id, data):
        food = self.food.find({"_id": ObjectId(id)})
        if not food:
            return
        
        self.food.replace_one({
                '_id': ObjectId(id)
            },
            data
        )

    #delete food
    def Delete_Food(self, id):
        try:
            self.food.delete_one({'_id': ObjectId(id)})
            return 200
        except ValueError as e:
            return e
