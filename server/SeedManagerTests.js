
const assert = require('assert')
const timekeeper = require('timekeeper')
const SeedManager = require('./SeedManager.js')

describe('SeedManager', () => {
    describe('#getSeed()', () => {
        beforeEach(() => {
            this.seedManager = new SeedManager(6000, 1000);
        });
        afterEach(() => {
            this.seedManager = null;
        });

        it('should return a valid seed', () => {
            const now = new Date();
            timekeeper.freeze(now);
            const seed = this.seedManager.getSeed();
            timekeeper.reset();
            assert.equal(seed.seed.length, 32);
            assert.ok(seed.expiredAt === now.getTime() + 6000);
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
    });
});

function laterDate(ms) {
    const now = Date.now()
    return new Date(now + ms)
}
