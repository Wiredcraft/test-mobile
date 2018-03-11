# How to design

### About server
I didn't use node.js before, so search how to build a node.js server and find npm, express and install them. Then write a simple api.

### About client api
Use retrofit, gson and okhttp. `ApiManager` is a singleton and easy to get `ApiService` to call api. `LogInterceptor` for log the request and response to debug app.

### FAB
Use animation for FAB to make them easier to understand.

### Permission
Permission checking fro Android 6.0 and above.

# How to run

### build server

- install npm and node.js

`https://nodejs.org/dist/v8.10.0/node-v8.10.0.pkg`

- install express

`http://www.expressjs.com.cn/starter/installing.html`

- copy app.js to `myapp` and run

`$ node app.js`

### config client and run

- open `BaseApplication` and change host with your server

- run `app` to install client and run