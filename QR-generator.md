# QR-generator

Make sure you have read the [README.md](https://github.com/Wiredcraft/mobile-test/blob/master/README.md) first.

## Background

There are 2 tasks:

1. Build a simple api server that can provide an API which generate a random seed.
2. Build a simple mobile application (very simple UI), that would call the seed API and generate a QR-code based on this seed.

### Seed Model

```
{
  data: '37790a1b728096b4141864f49159ad47'    // Random seed, length must be equal to 32
  expiredAt: 1452762065183                    // Unix format timestamp
}
```
*This user model is just an example, feel free to modify it.*

### API

```
GET    /seed                   - Get the seed
```

### User Interface

Here is a quick mockup of how it could look like (think Material Design!):![user interface](https://cloud.githubusercontent.com/assets/914595/12320458/cdca6356-bae3-11e5-8fd4-cff6ff647a12.jpg)

### Addtional Requirement

* QR-code could automaticlly refresh based on an expired date provide by the seed API.
* Mobile devices should cachekd the seed data and the seed can be restore after the user force close the app.

## Getting started

There's nothing here. We leave it blank (at least after this sentence) to write down your choice of build tool, code structure, framework, testing approach, etc.

![Home Scene Screenshot](static/screenshot.png)

### Requirements

Stable wireless network connection, a Mac, an iPhone (requires [Apple Developer account](https://developer.apple.com/register) and provisioning), and the following softwares are required:

```
Xcode Version 7.2 (7C68) (latest stable version on MAS) (with command line tools installed)
node v5.5.0
npm v3.7.0
psql (PostgreSQL) 9.5.0
```

### Up & Running for iOS

After [setting up PostgreSQL](http://www.postgresql.org/download/), you should create a simple database for the API. A quick example:

```
createuser <user> --password
createdb -O <user> <dbname>

psql -U <user> -d <dbname>

<dbname>=# \l
<dbname>=# grant all privileges on database <dbname> to <user>;
<dbname>=# grant all privileges on all tables in schema public to <user>;
<dbname>=# grant all privileges on all sequences in schema public to <user>;
<dbname>=# \q
```

Change directory to `QRGenerator`, which contains the source code of the app, install the dependencies.

```js
cd QRGenerator && npm i
```

Make sure there's no other process running on port `8080`, `8081`, `8082`, `8090`. we might use these ports later.

Set a few environment variables for the app, (relax, just two of them). You can choose your prefered way to manage them, or simply copy `.env.example` to `.env`. We only need `POSTGRES_CONNECTION_URI` and `API_HOST` here.

- `POSTGRES_CONNECTION_URI` [follows this pattern](http://www.postgresql.org/docs/9.5/static/libpq-connect.html#AEN42494).
- `API_HOST` is what you can get to the API Server, it's just something like `http://YOUR_IPHONE_CAN_ACCESS_THIS_IP_AND_THIS_IS_ON_YOUR_MAC:8090`. Because you have to run this app on a real device (iOS Simulator cannot access the camera, but we have a feature). You may have to set one IP address manauly: you can press `⌥` and click the Wireless Icon on the top menu bar on your screen to remember it, or just execute `npm run show-my-ip` in current directory, then set the `API_HOST` with your prefered IP address.

```
POSTGRES_CONNECTION_URI=postgres://user:pass@localhost:5432/qrgenerator
API_HOST=http://localhost:8090
```

Start the app server, wait for the server inited and React packager ready.

```js
npm start
```

Until you see the last line: `<END> Building Dependency Graph`. Then open another terminal tab, change directory to `QRGenerator`, run the bundle & build script, wait for Xcode opens the project.

```
cd QRGenerator
npm run build-ios
```

At last, connect your iPhone to your Mac. Switch to Xcode, press `⌘R`. Hopefully the app will be running on your iPhone.

### Debugging

This repo set default build configuration as `Release` mode, and the steps above will load from pre-bundled file on the device. If you want to enable debugging, please check out the following steps:

- Edit `ios/QRGenerator/AppDelegate.m`, uncomment Line 34, comment Line 42 as to load bundle from development server.
- Open `Xcode > Product > Scheme > Edit Scheme`, set `Build Configuration` to `Debug`
- If you want to debug on device, Edit `node_modules/react-native/Libraries/WebSocket/RCTWebSocketExecutor.m` Line 54, change `localhost` to your own IP addresss, that'll be all right.

### Testing

For now, this repo only contains basic test case for API `GET /seed`, you can run `npm run test-dev-api` to check it out.

The unit testing on React Native is a bit messy, Jest from Facebook is full of bug and surprises. I'll try out more test framework later.

