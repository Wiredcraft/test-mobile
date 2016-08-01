# QR-generator

Make sure you have read the [README.md](https://github.com/Wiredcraft/mobile-test/blob/master/README.md) first.

## Background

There are 2 tasks:

1. Build a simple api server that can provide an API which generate a random seed.
2. Build a simple mobile application (very simple UI), that would call the seed API and generate a QR-code based on this seed.

### Seed Model

```
{
  data: '37790a1b728096b4141864f49159ad47'    // Random seed, length must be equal to 32
  expiredAt: 1452762065183                    // Unix format timestamp
}
```
*This seed model is just an example, feel free to modify it.*

### API

```
GET    /seed                   - Get the seed
```

### User Interface

Here is a quick mockup of how it could look like (think Material Design!):![user interface](https://cloud.githubusercontent.com/assets/914595/12320458/cdca6356-bae3-11e5-8fd4-cff6ff647a12.jpg)

### Addtional Requirement

* QR-code could automaticlly refresh based on an expired date provide by the seed API.
* Mobile devices should cached the seed data and the seed can be restore after the user force close the app.

## Getting started

There's nothing here. We leave it blank (at least after this sentence) to write down your choice of build tool, code structure, framework, testing approach, etc.

### build tools / how to build & run?
- npm for server
    + run command `cd server && npm install` in project root to install server dependencies
    + run `npm run test` to run server tests. if there's failure, please leave a comment in my PR. thanks!
    + run `npm run start` to start the server
- cocoapods and Xcode for iOS app
    1. *change the value of `apiUrl` in `SeedManager.swift` to your server ip*
    2. run command `cd QR && pod install && open QR.xcworkspace` in project root to install app dependencies and open the app project in Xcode.
    3. make sure you completed step 1, then use Xcode shortcut `command+u` to build and run the tests. if there's failure, please leave a comment in my PR. thanks!
    4. use Xcode shortcut `command+r` to build and run the app.

### code structure
- server
    + `index.json`: the entry point of server
    + `SeedManager.js`: the main logic of seed generation and validation.
    + `SeedManagerTests.js`: the unit test of seed manager
- app
    + `Main.storyboard`: the ui and layout.
    + `ViewController.swift`: the entry point view controller, which contains logic of opening QR scan ui and validating the scan result.
    + `QRCodeViewController.swift`: the logic for QR code ui.
    + `SeedManager.swift`: the client proxy for seed server with caching.
    + `SeedManagerTests.swift`: unit tests for seed manager.
    + `SeedModel.swift`: the model of a seed.
    + `SeedModelTests.swift`: unit tests for seed model.
    + `SeedManagerIntegrationTest.swift`: integration test for swift seed manager and node.js seed manager.

### dependencies
- server
    + `express`: the well-known web framework for node.js
    + `body-parser`: used to parse the request body to json object.
    + `mocha`: the popular test framework. for assertion library, I use the node.js built-in assert module.
    + `timekeeper`: time api mock, used for testing seed expiration logic.
- app:
    + `Alamofire`: the convenient http request library.
    + `PKHUD`: the HUD ui library, used in validation ui when making http requests.
    + `QRCodeReader.swift`: the QR scan ui and logic.

### testing approach
- unit tests
    + server side: there are tests for domain logic code, `SeedManager.js`. use command `npm run test` to run the server tests. 
    + app side: there are tests for domain logic code, `SeedManager.swift` and `SeedModel.swift`. The server dependency of `SeedManager.swift` is mocked by subclassing. use shortcut `ctrl-u` in Xcode to run the client tests.
- integration tests
    + `SeedManagerIntegrationTest.swift` is for integration test between the app and the server.
- functional tests
    + automated functional ui tests is hard and brittle, I didn't adopt it. I manually test features through ui. 
