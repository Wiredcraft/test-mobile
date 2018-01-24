## Usage

### Server
You can run swift server or rails server, it dependents your favor and system.

#### Swift Server
Before you begin ，make sure your macOS version number is greater than 10.12.

- `cd QRGeneratorAPISwift`
- `build swift`
	- download dependencies and build 
- `.build/x86_64-apple-macosx10.10/debug/QRGeneratorAPISwift`
	- run server

#### Rails Server

- `cd QRGeneratorRails`
- `bundle install`
	- download dependencies
- `rails server`
	- run server
 

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