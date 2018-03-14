# How to design

### About server
I didn't use node.js before, so search how to build a node.js server and find npm, express and install them. Then write a simple api.

### About client api
Use retrofit, gson and okhttp. `ApiManager` is a singleton and easy to get `ApiService` to call api. `LogInterceptor` for log the request and response to debug app.

### FAB
Use animation for FAB to make them easier to understand.

### Auto-refresh strategy
First, auto-refresh strategy is a client side strategy. Client knows when will the seed expire and auto refresh the seed when it expired. And we need refresh the count down every second. So I think `CountDownTimer` is the best choice.

And then I create a `TextView` sub class with a `CountDownTimer` as a general count down view. Just provides a `onFinish` callback for the caller. Then our main logic only need to process what to do when expired.

Additionally, we need process the timer when activity stop or start.

Regarding `expires_at`, I think time string is not the best way for API. Client needs to convert and consider time zone. So timestamp is better, and I add `expires_at_long` in seed object.

### Offline QR code access strategy
Sometimes network is unstable and last seed is not expired, so we can cache it and re-use it if the network is not good and we can't get the newest seed.

For this purpose, we just need the latest seed. So I just save it in `SharedPreferences`, and override it if exists.

### Scan feature
First, QR code scanner is not a simple component, so I choose one 3rd party lib. Regarding we need customize the scan UI, so I choice this lib which can use as a component, in this case, it is a fragment.

Scanner needs camera, so I consider permission checking for Android 6.0 and above. I used official advice and used different methods to request permission at the first time and later, for smoothly and easily obtaining the permission.

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