## Build Tools

* npm & mongodb for server side
* Xcode with cocoapods for iOS app

## How to build and run

### Server

1. `cd QRGeneratorApi` - change working directory into server
2. `npm install` - install server dependencies
3. `npm run start` - start the sever

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