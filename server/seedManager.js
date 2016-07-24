
function getRandomSeed() {
    var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
    var text = "";
    for (var i = 0; i < 32; ++i) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

function expireTimeout(seed) {
    if (!seed) return -1;
    const now = Date.now();
    return seed.expiredAt - now;
}

class SeedManager {
    constructor(defaultExpireTimeout, minimumExpireTimeout) {
        this.defaultExpireTimeout = defaultExpireTimeout;
        this.minimumExpireTimeout = minimumExpireTimeout;
    }
    getSeed() {
        if (expireTimeout(this.seed) >= this.minimumExpireTimeout) {
            return this.seed;
        }
        this.seed = {
            seed: getRandomSeed(),
            expiredAt: Date.now() + this.defaultExpireTimeout
        };
        return this.seed
    }
    validateSeed(seed) {
        return expireTimeout(this.seed) > 0 && seed === this.seed.seed
    }
}

module.exports = SeedManager
