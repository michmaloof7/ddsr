import pymongo
import json

#class in charge of all the database transactions

class Database():

    _db_client = pymongo.MongoClient('mongodb://localhost:27017/')
    _default_db = _db_client.db
    _instance = None


    def __init__(self):
        self.client = Database._default_db.client
        self.food = Database._default_db.food
        self.order = Database._default_db.order
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = object.__new__(cls)
        return cls._instance

    #get all foods
    def get_foods(self):
        return [food for foods in self.food.find()]
    
    #get a food by id
    def get_food(self, id):
        return self.food.find({"_id": id})

    