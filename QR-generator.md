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
*This seed model is just an example, feel free to modify it.*

### API

```
GET    /seed                   - Get the seed
```

### User Interface

Here is a quick mockup of how it could look like (think Material Design!):![user interface](https://cloud.githubusercontent.com/assets/914595/12320458/cdca6356-bae3-11e5-8fd4-cff6ff647a12.jpg)

### Addtional Requirement

* QR-code could automaticlly refresh based on an expired date provide by the seed API.
* Mobile devices should cached the seed data and the seed can be restore after the user force close the app.

## Getting started

There's nothing here. We leave it blank (at least after this sentence) to write down your choice of build tool, code structure, framework, testing approach, etc.
