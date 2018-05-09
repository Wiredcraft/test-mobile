# QR-generator

## Design
To accomplish this task, I created an ASP.NET API Server and a Kotlin Android Client.

### Server
API Server (QRCodeSeedGenerator) that provides a single GET interface

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

### Testing
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


### Client
Kotlin
Android
TODO

## Delete Below?? 

Make sure you have read the [README.md](https://github.com/Wiredcraft/mobile-test/blob/master/README.md) first.

## Context

- A client needs to display a QR code it in their App.
- The App is a typical user membership App, which can be used to login and manage one's membership.
- The QR code can be used to identify one's membership or similar.

## Requirements

### Tasks

1. Build a simple API server that can provide an API which generates a random seed.
2. Build a simple App that can call the seed API and generate a QR code based on the seed.

### UI

Here is a quick mockup of how it could look like (think Material Design!): ![user interface](https://cloud.githubusercontent.com/assets/914595/12320458/cdca6356-bae3-11e5-8fd4-cff6ff647a12.jpg)

### API

(in Open API 3.0 format)

```yaml
paths:
  /seed:
    get:
      description: Get a seed that can be used to generate a QR code
      responses:
        '200':
          description: seed issued
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Seed'
components:
  schemas:
    Seed:
      type: object
      properties:
        seed:
          type: string
          example: 37790a1b728096b4141864f49159ad47
        expires_at:
          type: dateTime
          description: ISO date-time
          example: '1985-04-12T23:20:50.52Z'
```

### Tech stack

- API
    - Use anything for the backend. We prefer Node.js.
- iOS
    - Use Swift
- Android
    - Use Kotlin 

### Bonus

- Write clear **documentation** on how it's designed and how to run the code.
- Provide proper unit test.
- Write good commit messages.
- An online demo is always welcome.

### Advanced requirements

These are used for some further challenges. You can safely skip them if you are not asked to do any, but feel free to try out.

- Provide an auto-refresh strategy, for example with the `expires_at` value.
- Provide an offline QR code access strategy. for example with a cache.
- Build a "Scan" feature that can demonstrate how it works (see the mock).
