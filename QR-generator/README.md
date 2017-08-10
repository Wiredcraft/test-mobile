# Documentation of QR Code App

## API Server

The API server is built with python3, it only has one seed api: `http://localhost:2333/api/seed`.

Start the server:

1. Install `bottle` by running: `pip install bottle`
2. Start server by running: `python3 server.py`


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

