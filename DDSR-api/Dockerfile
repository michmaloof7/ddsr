FROM python:3.6

#create folder for the backend archives
RUN mkdir /ddsr-api

#set workdir to that folder
WORKDIR /ddsr-api

#copy all the files to the folder
COPY * .

#install all dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

#expose port 5000
EXPOSE 5000

#start flask
ENTRYPOINT ["python","app.py"]