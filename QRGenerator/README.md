## Build Tools

* npm & mongodb for server side
* Xcode with cocoapods for iOS app

## How to build and run

### Server

1. `cd QRGeneratorApi` - change working directory into server
2. `npm install` - install server dependencies
3. `brew install mongodb` - install mongodb
4. `mongod` - start the mongodb
5. `npm run start` - start the sever

### iOS

1. `cd QRGenerator` - change working directory into iOS
2. `pod install` - install app dependencies
3. `open QRGenerator.xcworkspace` - open proejct
4. In Xcode use `cmd + r` to build and run the app

## Library

### Server

* `express` - Web framework for node.js
* `mongoose` - Connection node and mongodb
* `randomstring` - Generate random QRCode seed
* `nodemon` - Monitor for any changes in your node.js application and automatically restart the server

### iOS

* `Alamofire` - iOS http request library
* `MBProgressHUD` - For show loading or tips hud
* `QRCodeReader.swift` - To scan the QR

## FAQ

Q: When I run the command `mongod`, the terminal says

```
[initandlisten] exception in initAndListen: 20 Attempted to create a lock file on a read-only directory: /data/db, terminating
[initandlisten] shutdown: going to close listening sockets...
[initandlisten] shutdown: going to flush diaglog...
[initandlisten] now exiting
[initandlisten] shutting down with code:100
```

A: You should create `/data/db` directory before you run the command.

```
$ sudo mkdir /data/db
$ sudo chown -R $USER /data/db 
```