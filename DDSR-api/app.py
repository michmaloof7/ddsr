from flask import Flask
from flask_cors import CORS

#importing apis and models from core folder
from core.api_v1 import blueprint as api_v1

app = Flask(__name__)
#CORS(app)   -- CORS CONFIG
CORS(app, resources=r'/mongo/*')

#we register the blueprint of the api we will use
app.register_blueprint(api_v1)

if __name__=='__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)

