package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

public class Seed {
    private String seed;
    private long expiredTime;

    Seed(String seed, long expiredTime){
        this.seed = seed;
        this.expiredTime = expiredTime;
    }

    public String getSeed() {
        return seed;
    }

    @Override
    public String toString() {
        return String.format("{seed:%1$s,expiredTime:%2$d}", seed, expiredTime);
    }

    @Override
    public boolean equals(Object o) {
        if( o == null || !(o instanceof  Seed)){
            return false;
        }
        Seed seed = (Seed) o;
        if(seed.getSeed() == null && seed.seed != this.seed || !seed.seed.equals(this.seed)) return false;
        return expiredTime == seed.expiredTime;
    }

    public long getExpiredTime() {
        return expiredTime;
    }
}
