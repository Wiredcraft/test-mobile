const express = require('express');
const app = express();

const SeedManager = require('./SeedManager');
const seedManager = new SeedManager(6000, 1000);

app.get('/seed', (req, res) => {
    const reply = seedManager.getSeed();
    res.send(JSON.stringify(reply));
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log('Example app listening on port 3000!');
});
