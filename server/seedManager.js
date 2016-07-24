
function getRandomSeed() {
    var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
    var text = "";
    for (var i = 0; i < 32; ++i) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

function getSeed() {
    return {
        seed: getRandomSeed(),
        expiredAt: Date.now() + 6000
    };
}

module.exports = {getSeed}
