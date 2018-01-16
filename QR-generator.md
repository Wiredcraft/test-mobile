# QR-generator

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
