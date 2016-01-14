# QR-generator

Please make sure you have read the [README.md](https://github.com/Wiredcraft/mobile-test/blob/master/README.md) first.

## Background

Build a simple api server that provider an API could generate a random seed.

Build a simple mobile application with simple user interface, that could call the seed API and generate a QR-code reply on this seed.

### Seed Model

```
{
  data: '37790a1b728096b4141864f49159ad47'    // The random seed, length must equal 32
  expired_date: 1452762065183                 // Unix format timestamp
}
```
*This user model is just an example, feel free to modify it.*

### API

```
GET    /seed                   - Get the seed
```

### User Interface
![user interface](https://cloud.githubusercontent.com/assets/914595/12320458/cdca6356-bae3-11e5-8fd4-cff6ff647a12.jpg)

### Addtional Requirement

* QR-code could automaticlly refresh by the expired date comes from the seed API.

* Mobile devices should keep the seed data in somewhere and the seed can be restore after user force close the app.

## Getting started

There's nothing here, we leave it to you to choose the build tool, code structure, framework, testing approach...
