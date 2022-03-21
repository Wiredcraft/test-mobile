# Mobile Test - GitHub Users List App

## Requirement

* Cocoapods (version >= 1.10)
* Xcode 13 or higher

## How to run

1. clone this repo and change directory to the `test_mobile_project` folder
2. run command in terminal: `pod install`
3. open `test_mobile.xcworkspace` file
4. click `run` button

## How it's designed

### Overall
It's a typical `MVVM` pattern solution. I separated the Home Page and User Detail Page into 2 scenes, and with each one has its own View Model. In the view (e.g HomePageViewController) the view and sub views binding the view's  action, like button tapped, to view model's input property, and vice versa binding output from view model's output property to update it's view.

### Dependency Injection
For view models' user, you could just define a view model property on it's interface (protocol in Swift) and the `Resolver` framework will do the rest thing: create and implementation instance for you, which makes the view and view models more isolated.

### Rx
In an overall view, there's plenty rx code in this project, with its observable stream and `MVVM` pattern, the project actually uses a `Unidirection Data Flow` pattern: actions in and data out.

## Conclusion
It's a small but comprehensive test, I learned a lot during the development.


