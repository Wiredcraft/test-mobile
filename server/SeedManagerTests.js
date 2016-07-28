
const assert = require('assert')
const timekeeper = require('timekeeper')
const SeedManager = require('./SeedManager.js')

describe('SeedManager', () => {
    beforeEach(() => {
        this.seedManager = new SeedManager(6000, 1000);
    });
    afterEach(() => {
        this.seedManager = null;
    });

    describe('#validateSeed()', () => {
        it('should return true on valid seed', () => {
            const seed = this.seedManager.getSeed();
            const valid = this.seedManager.validateSeed(seed.seed);
            assert.ok(valid);
        });
        it('should return false on expired seed', () => {
            const seed = this.seedManager.getSeed();
            const sixSeconds = 6000;
            timekeeper.travel(laterDate(sixSeconds));
            const valid = this.seedManager.validateSeed(seed.seed);
            timekeeper.reset();
            assert.ok(!valid);
        });
        it('should return false on invalid seed', () => {
            this.seedManager.getSeed(); // force generate a seed.
            const valid = this.seedManager.validateSeed('lksjdfakjk11909uu2323lkjlsjdfa23');
            assert.ok(!valid);
        });
    });
    describe('#getSeed()', () => {
        it('should return a valid seed', () => {
            const now = new Date();
            timekeeper.freeze(now);
            const seed = this.seedManager.getSeed();
            timekeeper.reset();
            assert.equal(seed.seed.length, 32);
            assert.equal(seed.expiredAt, now.getTime() + 6000);
        });

        it('should cache seed before expiration', () => {
            const seed1 = this.seedManager.getSeed();
            const seed2 = this.seedManager.getSeed();
            assert.deepEqual(seed1, seed2);
        });

        it('should return a new seed when expires', () => {
            const seed1 = this.seedManager.getSeed();
            const sixSeconds = 6000;
            timekeeper.travel(laterDate(sixSeconds));

            const seed2 = this.seedManager.getSeed();
            timekeeper.reset();
            assert.notDeepEqual(seed1, seed2);
        });

        it('should return a new seed if seed is about to expire in 1s', () => {
            const seed1 = this.seedManager.getSeed();
            timekeeper.travel(laterDate(5001));

            const seed2 = this.seedManager.getSeed();
            timekeeper.reset();
            assert.notDeepEqual(seed1, seed2);
        });

        it('should return the old valid seed when restarts', () => {
            const seedFile = `savedSeed.${Date.now()}.json`;
            const seedManager1 = new SeedManager(6000, 1000, seedFile);
            const seed1 = seedManager1.getSeed();
            const seedManager2 = new SeedManager(6000, 1000, seedFile);
            const seed2 = seedManager2.getSeed();
            assert.deepEqual(seed1, seed2);
            require('fs').unlink(seedFile);
        });
    });
});

function laterDate(ms) {
    const now = Date.now()
    return new Date(now + ms)
}
