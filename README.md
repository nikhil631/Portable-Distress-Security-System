# Portable Distress Security System
This is a project associated with one of my courses which is Joy Of Engineering, This security web app is resposible for handling accounts, sending emails as well as whatsapp messages.

# Initial idea of this project
When a person is in distress he/she presses a button on our device, this device then sends a small request to our webserver which then takes this request and sends emails and messages to all the relatives of this user.
[Described in detail here](#how-does-it-work)

# System Design of API
![alt text](https://github.com/nikhil631/Portable-Distress-Security-System/blob/main/images/Network%20diagram%20example.png) 
# Web App Installation
1. Copy the .env file after defining config in it from here to `"joe\Portable Distress System\security\security"` For Worker run `"joe\Worker\worker\worker"`
2. Run `pip install -r "joe\Portable Distress System\security\requirements.txt" ` For Worker run `pip install -r "joe\Worker\worker\requirements.txt" ` 
3. Finally run `python3 joe\Portable Distress System\security\manage.py runserver 0.0.0.0:8000` For Worker run `python3 joe\Worker\worker\manage.py runserver 0.0.0.0:8010`

# Emails and Whatsapp messages
I have added Asynchronous support to this web app by creating a different django app "worker" which will on startup run a python script to continuously check redis queue for updates, The name of this redis queue can be configured in the .env file as REDIS_WORKER_QUEUE

# How does it work
Let me explain by consider the url of web app be webapp.com and worker be worker.com.
When we have to add data we have to send a post request to webapp.com/data/coordinate-x_coordinate-y_emergency/ along with headers containing the unique token when we have to add data about distress or accidents, coordinate-x and coordinate-y are strings and are basically latitude and longitude.
emergency is a boolean value and will only accept value such as 1 or 0, user-id is a field which is used to here to identify this data addition for which user, Every user has a unique id shown on their homepage.

Whenever a post api request to webapp.com/data/1_1_1 this means that coordinate x is 1 coordiante y is 1 emergency is set to True, token is supposed to be set in headers. after this, quickly a json format dictionary is made which contains all the information of the user from first_name,last_name to email, id , relatives emails and relatives phone numbers, this is then quickly added to a Redis Queue, this information is also created in sql database for homepage and future referencing, This step does not take much time and ends in less then a second and the user which posted this gets his return page quickly.

The redis queue in which we just appended the entries is being watched by worker.com as soon as it sees the entries it pops the information from queue and sends emails and messages to all the relatives with all the information such as name, latitude, longitude and much more. 
