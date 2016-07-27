package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

/**
 * A simple class for pack the random seed and its expired time together.
 * Notice that use Seed means this object and seed means the random seed string in it.
 * @version 1.0
 * @see SeedManager
 * @author shiyinayuriko
 */
public class Seed {
    private String seed;
    private long expiredTime;

    Seed(String seed, long expiredTime){
        this.seed = seed;
        this.expiredTime = expiredTime;
    }

    /**
     * Get the random seed string of the Seed object.
     * @return the random seed string of the Seed object.
     */
    public String getSeed() {
        return seed;
    }

    /**
     * Get the expired time of the Seed.
     * @return the expired time of the Seed.
     */
    public long getExpiredTime() {
        return expiredTime;
    }
    /**
     * Returns a string representation of the Seed object.
     * Usually for debug use.
     * @return a string representation of the Seed object.
     */
    @Override
    public String toString() {
        return String.format("{seed:%1$s,expiredTime:%2$d}", seed, expiredTime);
    }

    /**
     * Compares this seed with another object.
     * The result is true if and the argument is not null and is a Seed object with same seed and expired time as this object.
     * @param o The object to compare this Seed against
     * @return true if the given object represents a Seed equivalent to this Seed, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if( o == null || !(o instanceof  Seed)){
            return false;
        }
        Seed seed = (Seed) o;
        if(seed.getSeed() == null && seed.seed != this.seed || !seed.seed.equals(this.seed)) return false;
        return expiredTime == seed.expiredTime;
    }
}
