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

    public long getExpiredTime() {
        return expiredTime;
    }
}
