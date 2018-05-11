# QR-generator

## Design
To accomplish this task, I created an ASP.NET API Server and a Kotlin Android Client. [Try it out in the Web Browser!](https://appetize.io/embed/nwmw280f28cg1cwkgrk9aw2adr?device=nexus5&scale=75&orientation=portrait&osVersion=7.1)

## Server
API Server build on ASP.NET Web API that provides a single GET interface. 
- In a nutshell, GET /api/seed returns a random string seed and a datetime expires_at value. 
- The server is hosted on AWS: [http://qrcodeseedgenerator-dev.us-west-2.elasticbeanstalk.com/api/seed](http://qrcodeseedgenerator-dev.us-west-2.elasticbeanstalk.com/api/seed)
- The files for the server live in the QR-generator/QRCodeSeedGenerator directory. 

#### Description
Unfortunately there is a considerable amount of boilerplate to this ASP.NET Web Api Project, but these are the 3 most important files:
	- SeedController.cs
		* Controls the endpoint api/Seed
		* By extending ApiController, the method named Get() will be called when a GET is issued
		* In addition, Web API respects HTTP request headers and the resource returned will match the client request. So if the client accepts: text/html then it will be in html format. If the client accept: text/json it will be in json format, with no changes required on the server side.
	- SeedControllerTest.cs
		* Simple unit testing class to test the SeedController's Get() and GenerateRandomAlphaNumeric() methods
	- WebApiConfig.cs
		* Routing table 
		* By default creates route "api/{controller}/{id}"

#### Server Testing
Open the QRCodeSeedGenerator.sln
	- Build it and verify the unit tests pass
	- F5 (run in IE or Chrome) (confirm localhost:Port + default home page for Web API project appears) 
		-> in the internet explorer window press F12 (developer console -> network)
		-> ctrl-e (start profiling/capturing network traffic)
		-> append /api/seed to url (localhost:port/api/seed)
		-> verify in the network capture / Headers window that a 200 / OK status code was received from the GET Request
		-> verify, in the network capture / Body / Response body window that the correct output has been received
	- As I mentioned above, the Web API specifications response type will conform to the HTTP request headers and will be in HTML when querying from a browser
		* Using Fiddler, it's possible to compose a request using the same exact specifications but with the Accept field changed to text/json. The response will be JSON
	- Expected results:
		* Expires at: UTC date 30 minutes from now
		* Seed: length 32 string of random alphanumeric


## Client
A simple Android app, written in Kotlin, that can call the Server Seed API and then uses it to generate a QR code. The files for the client can be found in the QR-generator/QRCodeClient directory.
[Try it out in the Web Browser](https://appetize.io/embed/nwmw280f28cg1cwkgrk9aw2adr?device=nexus5&scale=75&orientation=portrait&osVersion=7.1)

#### Description
- HomeActivity.kt - define the home activity and set up the Floating Action Button logic
- QRSeedProvider.kt - define the API for accessing the QR Seed Server
- QRGenerationActivity.kt - define the QR Generation activity. Use the QRSeedProvider to get a QR Seed. If successful, generate and display the QR image. Otherwise, show an error message.

#### Libraries Used
- [RapidFloatingActionButton](https://github.com/wangjiegulu/RapidFloatingActionButton) - although google offers a simple floating action button in the support library, it takes a bit of work to set up menu of floating action buttons that appear when the primary button is clicked. 
- [ZXing Android Embedded](https://github.com/journeyapps/zxing-android-embedded) - an Android port of Google's ZXing barcode scanning and creation library.
- [RxJava / RxAndroid](https://github.com/ReactiveX/RxJava/wiki) - library for composing asynchronous and event-based programs by using observable sequences, with Android bindings
- [Retrofit](https://github.com/square/retrofit) - HTTP client, with Moshi and the RxJava adapter, to convert the JSON into an observable stream of Java (Kotlin) classes


#### Client Testing
Open the project in Android Studio.
	- Build and verify the unit tests and instrumentation tests pass
	- Change the build variant to MockDebug to get a fake QR seed result. Switch back to prodDebug to hit the web server
	- Run on an emulator or linked device
	- Hello Wiredcraft! should appear on the HomeActivity
	- Click the Floating Action Button in the bottom-right corner
	- A Scan Code button and a Generate Code button should both appear
	- Scan Code has not been implemented. Clicking it should just show a message letting the user know
	- Clicking Generate Code will launch the QR Code Generator activity. The activity may briefly show a loading icon, then the QR code should appear, with the text version of the code shown below it.
	- Test launching the Generate Code Activity again with the wifi/data OFF (enable airplane mode). The Activity should now show a message that the QR Code could not be fetched from the server.
	