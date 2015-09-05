# Wiredcraft iOS Developer Coding Test

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Background

Build a simple api server that could allow user create an account and login.

Build a simple iOS application with simple user interface, that allow user login with the app through the API you build.

### User Model

```
{
  "id": "xxx",                  // user id(you can use uuid or the id provided by database, but need to be unique)
  "name": "test",               // user name
  "dob": "",                    // date of birth
  "address": "",                // user address
  "description": "",            // user description
  "created_at": ""              // user created date
}
```
*This user model is just an example, feel free to modify it.*

### API

```
GET    /user/{id}                   - Get user by ID
POST   /user/                       - To create a new user
POST   /login                       - User login
POST   /logout                      - User logout
```

### User Interface
![user interface](https://cloud.githubusercontent.com/assets/914595/9623682/f22d8f4c-5176-11e5-88fb-133828455702.jpg)

## Getting started

#### Server Development Environment

* Python 2.7.10
* Flask 0.10.1
* Sqlite 3.8.5

#### iOS Development Environment

* Xcode 6.4

#### Project Structure

```
ios/            iOS project file
app.py          main server file
models.py       model and sqlite operation
schema.sql      sql for create tables
```

*One user divide into a user info table and a user auth table, this can make the extension of third authoristion login easily.*

#### Build & Run

1. create the database and tables: `$ sqlite3 test.db < schema.sql`
2. start the server: `$ python app.py`
3. open the simulator with Xcode and run the app

## Requirements

- With clear documentation on how to run the code and api usage;

- iOS application should follow apple design pattern;

- Provide proper unit test;

- Choose either sql or no-sql database to make the data persistence;

- Use git to manage code;


## What We Care About

Feel free to use any libraries you would use if this were a real production app, but remember we're interested in your code & the way you solve the problem, not how well you can use a particular library.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

Here's what you should aim for:

- Good use of some third part library or use your own;

- Solid testing approach;

- Extensible code;

## Q&A

* Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think you are done. We don't have deadline for the task.

* What if I have question?

Create a new issue in the repo and we will get back to you very quickly.


