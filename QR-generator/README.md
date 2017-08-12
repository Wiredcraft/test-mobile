# Documentation of QR Code App

[APP download link](https://rink.hockeyapp.net/apps/fac146a4cab04baf857d62c16a90d232)

## API Server

The API server is built with python3, it only has one seed api: `http://localhost:2333/api/seed`.

Start the server:

1. Upgrade Python to version `3.6`
2. Install `bottle` by running: `pip install bottle`
3. Start server by running: `python3 server.py`


## APP

### Features

- Scan a QR-Code
- Generate a QR-Code with a seed from the server, refresh if the QR-Code is expired
- Save all QR-Codes


### Libraries

- floatingactionbutton
- retrofit
- barscanner
- QRGen
- room


## Tests

- API test with mockito
- FAB menu test with Espresso


## Gradle Tools

There is a task named `upoload`, run this task after finishing `assembleRelease`, it will upload the APK to hockeyapp platform.

### How to speed up Android Building?

- Enable `Offline` mode in Gradle Settings.
- Enable `Parallel` mode in Compiler Settings.
- Enable `Configure on demand` mode in Compiler Settings.
- Use `Daemon` by setting `org.gradle.daemon` to `true`.
- Increase memory allocation if needed.

### How to automate workflow

- Rename release APK name with gradle.
- Automatically archive all release APK after building is finished with gradle.


## Explanation

I upload some credentials on purpose, like keystore, keystore pass and upload token. I know it's very bad on production. Since this is a task and all those credentials are used in this project only, it's better to have them for you guys to test my code.

