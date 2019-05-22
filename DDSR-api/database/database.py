import pymongo
import json
from bson.objectid import ObjectId



#class in charge of all the database transactions

class Database():

    _db_client = pymongo.MongoClient('mongodb://localhost:27017/')
    #we set up the default database for our collections which is local
    _default_db = _db_client.local
    _instance = None

    def __init__(self):
        self.food = Database._default_db.food
        self.clients = Database._default_db.clients
        self.order = Database._default_db.order
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = object.__new__(cls)
        return cls._instance

    #-------- FOOD OPERATIONS -------#
    
    #get all foods
    def Get_Foods(self):
        return [food for food in self.food.find()]
    
    #get a food by id
    def Get_Food(self, id):
        return self.food.find({"_id": ObjectId(id)})

    #get a food by type
    def Get_Food_Type(self, food_type):
        return [food for food in self.food.find({"type": food_type})]

    #add food
    def Add_Food(self, new_food):
        check = self.food.find_one({'name': new_food['name']})
        if check:
            return False
        elif not check:
            self.food.insert_one(new_food)
            return True

    #update food
    def Update_Food(self, id, data):
        food = self.food.find_one({"_id": ObjectId(id)})
        if not food:
            return False
        elif food:
            self.food.replace_one({
                '_id': ObjectId(id)
                },
                data
            )
            return True

    #delete food
    def Delete_Food(self, id):
        food = self.food.find({'_id': ObjectId(id)})
        if not food:
            return False
        elif food:    
            self.food.delete_one({'_id': ObjectId(id)})
            return True
            
    #-------- CLIENT OPERATIONS ----------#

    #get all clients
    def Get_Clients(self):
        return [client for client in self.clients.find()]

    #get a client by id
    def Get_Client(self, id):
        return self.clients.find({'_id': ObjectId(id)})
    
    #add a client
    def Add_Client(self, new_client):
        check = self.clients.find_one({'name': new_client['name']})
        if check:
            return False
        elif not check:
            self.clients.insert_one(new_client)
            return True

    #Update a client
    def Update_Client(self, id, data):
        client = self.clients.find_one({'_id': ObjectId(id)})
        if not client:
            return False
        elif client:
            self.clients.replace_one({
                '_id': ObjectId(id)
            }, data)
            return True

    #Delete a client
    def Delete_Client(self, id, data):
        client = self.clients.find_one({'_id': ObjectId(id)})
        if not client:
            return False
        elif not check:
            self.clients.delete_one({'_id': ObjectId(id)})
            return True
    
    #--------Orders operations---------#
    
    #Get all orders
    def Get_Orders(self):
        return [order for order in self.order.find()]
    
    #Get an order by id
    def Get_Order(self, id):
        return self.order.find_one({'_id': ObjectId(id)})

    #Add an order
    def Add_Order(self, new_order):
        try:
            self.order.insert_one(new_order)
        except pymongo.errors.PyMongoError as e:
            return False
        
        return True
        
    #Update an order
    def Update_Order(self, id, data):
        order = self.order.find_one({'_id': ObjectId(id)})
        if not order:
            return False
        elif order:
            self.order.replace_one(
                {'_id': ObjectId(id)
            }, data)
            return True

    #Delete an order(self, id, data):
    def Delete_Order(self, id):
        order = self.order.find_one({'_id': ObjectId(id)})
        if not order:
            return False
        elif order:
            self.order.delete_one({'_id': ObjectId(id)})
            return True
