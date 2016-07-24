
function getRandomSeed() {
    var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
    var text = "";
    for (var i = 0; i < 32; ++i) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

function expireTimeout(seed) {
    const now = Date.now();
    return seed.expiredAt - now;
}

class SeedManager {
    constructor(defaultExpireTimeout, minimumExpireTimeout) {
        this.defaultExpireTimeout = defaultExpireTimeout;
        this.minimumExpireTimeout = minimumExpireTimeout;
    }
    getSeed() {
        if (this.seed && expireTimeout(this.seed) >= this.minimumExpireTimeout) {
            return this.seed;
        }
        this.seed = {
            seed: getRandomSeed(),
            expiredAt: Date.now() + this.defaultExpireTimeout
        };
        return this.seed
    }
}

module.exports = SeedManager
