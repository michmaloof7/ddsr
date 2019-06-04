from datetime import datetime
import json

#This file serves the purpose of changing the id keys

def correct_id(dictionary):
    for item in dictionary:
        item['id'] = item['_id']
        del item['_id']
    
    return dictionary

class DateTimeEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, datetime):
            return o.strftime('%Y/%m/%d')
            
        return json.JSONEncoder.default(self, o)

