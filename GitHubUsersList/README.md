# GitHubUsersList

This Application implements MVVM architecture using Hilt, Coroutines, Flow, ViewModels and Retrofit.

Load user list from GitHub api and use Paging3 with Flow to show it in a RecyclerView.

Use Navigation to perform Fragment navigation.

The app has following packages:

1. `adapter`: Data adapter and data binding adapter
2. `api`: Network request api and service
3. `di`: Inject Retrofit api service dependency
4. `model`: All data access components
5. `util`: Constants and extensions
6. `view`: Custom view
7. `viewmodel`: ViewModels

and Activities and Fragments

## Getting Started

- Clone this project

    ```shell
    git clone git@github.com:jaymengxy/test-mobile.git
    ```

- Open in **Android Studio**, build the project and run 'app'

## TODO

- Use Paging LoadStateAdapter to displaying LoadState.
- Learn how to write good Test.

## Libraries Used

- [Foundation][0] - Components for core system capabilities, Kotlin extensions and support for
  multidex and automated testing.
    - [AppCompat][1] - Degrade gracefully on older versions of Android.
    - [Android KTX][2] - Write more concise, idiomatic Kotlin code.
    - [Test][3] - An Android testing framework for unit and runtime UI tests.
- [Architecture][4] - A collection of libraries that help you design robust, testable, and
  maintainable apps. Start with classes for managing your UI component lifecycle and handling data
  persistence.
    - [Data Binding][5] - Declaratively bind observable data to UI elements.
    - [Lifecycles][6] - Create a UI that automatically responds to lifecycle events.
    - [LiveData][7] - Build data objects that notify views when the underlying database changes.
    - [Navigation][8] - Handle everything needed for in-app navigation.
    - [ViewModel][9] - Store UI-related data that isn't destroyed on app rotations. Easily schedule
      asynchronous tasks for optimal execution.
- Third party and miscellaneous libraries
    - [Glide][10] for image loading
    - [Hilt][12] for [dependency injection][13]
    - [Kotlin Coroutines][11] for managing background threads with simplified code and reducing needs for callbacks
    - [Espresso][14] Espresso is a testing framework for Android to make it easy to write reliable user interface tests.

[0]: https://developer.android.com/jetpack/components
[1]: https://developer.android.com/topic/libraries/support-library/packages#v7-appcompat
[2]: https://developer.android.com/kotlin/ktx
[3]: https://developer.android.com/training/testing/
[4]: https://developer.android.com/jetpack/arch/
[5]: https://developer.android.com/topic/libraries/data-binding/
[6]: https://developer.android.com/topic/libraries/architecture/lifecycle
[7]: https://developer.android.com/topic/libraries/architecture/livedata
[8]: https://developer.android.com/topic/libraries/architecture/navigation/
[9]: https://developer.android.com/topic/libraries/architecture/viewmodel
[10]: https://bumptech.github.io/glide/
[11]: https://kotlinlang.org/docs/reference/coroutines-overview.html
[12]: https://developer.android.com/training/dependency-injection/hilt-android
[13]: https://developer.android.com/training/dependency-injection
[14]: https://developer.android.com/training/testing/espresso/
