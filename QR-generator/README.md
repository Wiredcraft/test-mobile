## Usage

### Server

Before you begin ，make sure your macOS version number is greater than 10.12.

- `cd QRGeneratorAPISwift`
- `swift build`
	- download dependencies and build 
- `.build/x86_64-apple-macosx10.10/debug/QRGeneratorAPISwift`
	- run server
	- the path denpends on your system. you will find it in log after executing `swift build`

### App

- `cd QRGenerator`
- `pod install`
	- download dependencies
- `open QRGenerator.xcworkspace`
- `cmd + r` 
	- run the app
- `cmd + u` 
	- run the unit test

## Dependency

### App

- SnapKit
	-  A Swift Autolayout DSL for iOS & OS X
- ObjectMapper
	- JSON Object mapping 
- Moya
	- Network abstraction layer
- Toast-Swift
	- Toast for iOS
- RHSideButtons
	- Floating action button for iOS