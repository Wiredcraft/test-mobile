
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

const fs = require('fs');

function saveSeed(seed, seedFile) {
    if (!seedFile) return;
    const jsonString = JSON.stringify(seed);
    fs.writeFileSync(seedFile, jsonString, 'utf8');
    console.info(`seed saved ${jsonString}`);
}
function loadSeed(seedFile) {
    if (!seedFile) return null;
    try {
        const jsonString = fs.readFileSync(seedFile, 'utf8');
        const seed = jsonString && JSON.parse(jsonString);
        console.info(`seed loaded ${jsonString}`);
        return seed;
    } catch (err) {
        console.error(`failed to load seed from ${seedFile}: ${err}`)
        return null;
    }
}

class SeedManager {
    constructor(defaultExpireTimeout, minimumExpireTimeout, savedSeedFile) {
        this.defaultExpireTimeout = defaultExpireTimeout;
        this.minimumExpireTimeout = minimumExpireTimeout;
        this.seedFile = savedSeedFile
        this.seed = loadSeed(this.seedFile);
    }
    getSeed() {
        if (expireTimeout(this.seed) >= this.minimumExpireTimeout) {
            return this.seed;
        }
        this.seed = {
            seed: getRandomSeed(),
            expiredAt: Date.now() + this.defaultExpireTimeout
        };
        saveSeed(this.seed, this.seedFile);
        return this.seed
    }
    validateSeed(seed) {
        return expireTimeout(this.seed) > 0 && seed === this.seed.seed
    }
}

module.exports = SeedManager
