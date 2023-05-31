# Mobile Test - GitHub Users List App

# User 
- userName :李慧强
- phone number: 13917635614（weChat）
- email: 15116393675@163.com

# Some of my requests
First of all, thank you for viewing this content. I wish you good luck in your work.
If you can, give me some suggestions, including the architecture, coding details or how you feel after dealing with this matter, 
you can send it to my email. This feedback is very helpful to me. Thank you very much.

# MobileApp sample
MobileApp is a sample test project, build with Kotlin、Retrofit、Coroutine、Flow、ViewModel、LiveData, etc.

# Requirements
1. jdk11
2. gradle 7.3
3. android-gradle-plugin 7.2.1

## about package
1. bean: the datasource class for UI
2. data: the datasource for test
3. domain: network API definition and network general result wrapper class, etc.
4. ext: extended function
5. net: Network request tool and URL
6. scope: Define various scopes
7. shareviewmodel: data share viewModels
8. ui: the page(activity/fragment)
9. utils: some utils
10. widget: Custom UI

## about design
The core of the project is divided into three layers
1. Repository: Provide functions such as network requests, database operations, time-consuming tasks, etc.
2. UserCase: the transformation layer of the business scenario, convert the data source to the data required by the business layer
3. ViewModel: Bind pages(Activity/Fragment), each page has a unique ViewModel

tips: UserCase layer is optional, and UserCase can be added when the business is complex.

data flow： repository -> [userCase] -> ViewModel -> UI
user event flow：UI -> ViewModel -> [userCase] -> repository

tips:
The domestic network request return structure is basically the following structure
``` json
{
    "code": 0,
    "message": "",//some message or null
    "data": null
}
```
We will deal with data or message according to code. If it is a business failure, we will prompt the user with message. 
If it is correct, we will use the data field to display the information.
Based on the above, I designed UIState to package the data. After the data is returned, 
it will be processed into UIState and arrive at UI according to the data flow.