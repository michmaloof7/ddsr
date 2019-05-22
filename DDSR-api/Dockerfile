FROM python:3.6

#copy the requirements txt to install all dependencies
COPY ./requirements.txt .

#create folder for the backend archives
RUN mkdir /ddsr-api

#install all dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

#expose port 5000
EXPOSE 5000

#set python path to ddsr-api
ENV PYTHONPATH=/ddsr-api

#copy the folder contents into the container
COPY . /ddsr-api

#set workdir to that folder
WORKDIR /ddsr-api

#start flask
ENTRYPOINT ["python","app.py"]