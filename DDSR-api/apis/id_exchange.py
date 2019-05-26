#This file serves the purpose of changing the id keys

def correct_id(dictionary):
    for item in dictionary:
        item['id'] = item['_id']
        del item['_id']
    
    return dictionary
