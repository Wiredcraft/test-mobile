const express = require('express');
const app = express();

app.get('/seed', (req, res) => {
    // todo: return a fake seed for now.
    const reply = {
        seed: "37790a1b728096b4141864f49159ad47",
        expiredAt: Date.now() + 60000
    };
    res.send(JSON.stringify(reply));
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log('Example app listening on port 3000!');
});
