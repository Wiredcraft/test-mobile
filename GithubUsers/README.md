## Design

The App use a MVVM framework built on RxJava, it support dark mode

#### Network request

Use Okhttp, Retrofit and Gson as a base library. Every list request inherits from `BaseListRequest`. 

`BaseListRequest` provider some feature: save cache automatically, error handling etc.

Using `BaseListRequest` and `BaseListViewModel` together will save a lot of time. For example

- when the user open the page for the first time, the cache will be displayed automatically, and save latest data to cache
- No need to deal the error
- the api page flag will be set automatically
- I found that the api have duplicate data sometimes, so I used a set to ensure that the data is not repeated
- In the Github Api document, the json returned by the Github, `incomplete_results` may be true. If `incomplete_results` is true, I will request again and choose the best result to display

#### User List Page

In order to make a good user experience, custom a `SearchFrameLayout`  to handle the linkage between SearchBar and UserList

#### User Detail Page

Open User's homepage with a WebView

## Run

- Clone this project and open it
- Run `app` 

