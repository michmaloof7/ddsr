## HOW TO ACTIVATE API

if you don't have pip or python installed then, [install them](https://realpython.com/installing-python/)

With pip, use:
    - pip install pipenv

After pipenv is installed from this folders root (ddsr-api), use:
    - pipenv install

After everything is installed then use:
    - pipenv shell

Said command will make you enter the virtual environment created for this project, from there
just use:
    - python app.py

The app will be running on localhost:5000/mongo

## SET UP MONGODB

There are two options, or using docker-compose or [installing mongodb](https://www.mongodb.com/download-center/community) on your computer, follow the default instructions and it will be just
running as a service on the background, if you wish download compass so you can access the database
and see any change you make.

If you decide to use docker-compose then you need to have a working installation of docker and docker-compose in your machine. Then just run: suno docker-compose up from the projects root.

That's all, it will be running the same ports as usual.