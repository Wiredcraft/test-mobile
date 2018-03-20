# QR Membership Service

The QR membership service is a service, which allows users to get membership data from our service in their mobile application displayed as a QR code and also read other people's membership by scanning the QR code on the screen of their device.

From technical side, the service consists of two main components:
- Swift iOS application
- Golang backend

## iOS application architecture and tech decisions
The general consensus for the application is to have safe, scalable and elegant design and minimize external dependencies to make the codebase reliable and testable.


### UI
The iOS application uses standard MVC architecture, where the viewcontrollers are the central component for connecting model and view. Some parts of the app also use MVVM architecture, which is a good way to scale the app when code in the viewcontrollers increases. 
UI is generated with SnapKit on the code instead of storyboards to make it easy for other developers to read and analyse it. It is also a good approach in order to prevent(/help solving) merge conflicts in the version control.

### Asynchronous operations and networking
The application implements custom `AsyncOperation` type, which wraps BrightFutures Future type inside of it. This gives us more control over the asynchronous operations and allow easily to implement custom functionality. i.e. Binding the operation state changes to loading indicator, binding events to actions etc.
Application also has it's own implementation of HTTP client on top of the standard URLSession provided by Apple Foundation library. 

### Models
Application implements BaseDict class which is a safe wrapper for dictionaries received for example from network requests (JSON). It provides multiple safe getters with default fallbacks such as `stringOrEmpty` or `intOrZero`.

### Other 
- The project uses compiler flag to treat warnings as compile time errors. This helps in keeping the codebase stable and clean of error messages/issues.
- Application provides base-class for multiple components like Unit tests, ViewControllers, ViewModels, UserDefaults etc. With this approach, common functionality/properties can be safely shared/extended instead of being copied/repeated.
- Info.plist allows bypassing Apple non-HTTPS restriction on localhost addresses for development and testing
- Since single user may only have one membership at a time, `QRMembership` objects are cached to NSUserDefaults and set to expire as defined by the backend `expires_at` property.
- QRCode class can generate QR codes with WiredCraft logo embedded in the center. This will not be an issue, because the logo will take about ~7% of the space and can be recovered by the QR parsing algorithm.
- Application uses `with<T>()`-function defined in `General.swift` to keep property declarations and configurations in the same place.
- Strings are stored in the application explicitly. In actual large scale application they should be stored to localization files and fetched from there. This is a known decision.
- Dependencies are handled with Carthage. Exact versioning is used for maximum safety and to mitigate problems in case external libraries fail to follow semantic versioning principles.

## Golang backend
Golang backend is a simple REST-API with one endpoint: `/seed`.
The backend provides membership as 32 UTF-8 characters long token `seed` and expiry value `expires_at`. Expiration time is set 2 hours after issuing the membership token i.e. calling the endpoint.

Example:

    GET /seed HTTP/1.1
    
    HTTP/1.1 200 OK
    
    {
        "seed":"2OzjqLyeTDxXzNRTTLcGLbhUoug3DYky",
        "expires_at":"2018-03-20T18:05:07Z"
    }
### Why Golang?
- High performance (although not critical in this case)
- Stable and comprehensive standard library
- Static typing & compile time safety checks
- Simple and non-verbose, easy to read

# How to run the service
You need golang and carthage installed to run the service.

 1. Clone the repository
 2. Get the mux dependency for the go backend by running `go get github.com/gorilla/mux`
 3. Start the backend service: `go run backend/main.go`
 4. Get SnapKit and BrightFutures for iOS application by running `carthage bootstrap --platform ios` in side the `QRApp` folder
 5. Open the iOS application project in XCode, build and run in simulator.
 **Note:** If you want to run the app on physical device, you need to run the backend on the same network and add the IP address of the backend computer to the `NSAppTransportSecurity` exceptions in `Info.plist`

# Demo video
Available at: https://youtu.be/1J_QM8FsDPg
