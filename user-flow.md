# User-flow

Please make sure you have read the [README.md](https://github.com/Wiredcraft/mobile-test/blob/master/README.md) first.

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

There's nothing here, we leave it to you to choose the build tool, code structure, framework, testing approach...
