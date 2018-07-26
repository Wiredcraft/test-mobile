# QRGenerator

## App Features

- Scan QR code.
- Generate QR code according to the seed provided by server and display it. Refresh the QR code every 60 seconds.
- Display cached QR code when offline.


[Android app(debug mode)](https://fir.im/qrgenerator)
## How to run

### server
- install node.js and npm
`https://nodejs.org/dist/v8.11.1/node-v8.11.1.pkg`

you also can install node and npm use NVM

- download or clone this QRGenerator project to your workspace, open terminal and into the QRGenerator directory(MAC OS)


- `cd QRServer` - change your working directory to server

- `npm install` - install server's dependencies

- `npm start` - start api sever

Now you can access the API by visiting `http://localhost:1023/api/seed` in your browser

### android client

- open `QRClient` in your download directory. Open it with Android Studio or IDEA

- waiting for gradle download dependencies.
If any sdk or platform tools are missed, please follow the installation instruction.

- run project or using ./gradlew assembleDebug in terminal at root directory of Android project to build apk


## Use Library

### server

- `randomstring` library for generating random strings
- `express` framework for node.js
- `dayjs` 2KB immutable date library alternative to Moment.js with the same modern API

### android client

- `zxing-library` - QR code generation library
- `retrofit2` - network request library
- `joda-time.jar` - time library


## CI
In order to automate the build, circle.yml has been added to the project root directory.

Using circleCI to run unit test and upload apk file automatically when git push your code on master branch

If circleCI run success, you can see a new apk at `https://fir.im/qrgenerator`


## Attention
please change the IP address of API_URL parameter of QRApiClient (like `"http://192.168.100.212:3600"`) to your local area network's IP address when using your device. The port 3600 can`t change
