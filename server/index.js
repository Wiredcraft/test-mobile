const express = require('express');
const app = express();

app.get('/seed', (req, res) => {
    // todo: return a fake seed for now.
    const reply = {
        seed: Date.now(),
        expiredTimeout: 60
    };
    res.send(JSON.stringify(reply));
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log('Example app listening on port 3000!');
});
