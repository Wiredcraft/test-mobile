const express = require('express');
const app = express();

function getRandomSeed() {
    var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
    var text = "";
    for (var i = 0; i < 32; ++i) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

app.get('/seed', (req, res) => {
    const reply = {
        seed: getRandomSeed(),
        expiredAt: Date.now() + 6000
    };
    res.send(JSON.stringify(reply));
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log('Example app listening on port 3000!');
});
