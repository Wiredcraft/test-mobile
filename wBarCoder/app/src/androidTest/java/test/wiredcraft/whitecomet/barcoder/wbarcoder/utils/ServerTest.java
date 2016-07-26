package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import android.test.suitebuilder.annotation.LargeTest;

import org.junit.Before;
import org.junit.Test;

import java.util.Random;
import java.util.regex.Pattern;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.DefaultSeedParser;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.Seed;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.SeedManager;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

@LargeTest
public class ServerTest {
    private static final String TEST_BASE_URL = Constant.SERVER_HOST;
    private static final String TAG = "ServerTest";

    private Network network;

    @Before
    public void setUp() throws Exception {
        network = new Network();
    }

    @Test
    public void testServerConnect()throws Exception{
        String ret = network.getSync(TEST_BASE_URL);
        assertTrue(ret != null);
    }

    @Test
    public void testDefaultParser() throws Exception{
        SeedManager.SeedParser parser = new DefaultSeedParser();
        String ret = network.getSync(TEST_BASE_URL);
        assertTrue(parser.parse(ret) != null);
    }

    @Test
    public void testSeedFormat() throws Exception{
        SeedManager.SeedParser parser = new DefaultSeedParser();
        String ret = network.getSync(TEST_BASE_URL);
        Seed seed = parser.parse(ret);

        Pattern pattern = Pattern.compile("[0-9|a-f|A-F]*");
        WcLog.test(TAG,"seed " + seed.getSeed());
        assertTrue(pattern.matcher(seed.getSeed()).matches());
        assertEquals(seed.getSeed().length(), 32);

        WcLog.test(TAG,"ExpiredTime " +  seed.getExpiredTime());
        assertTrue(Math.abs(seed.getExpiredTime() - System.currentTimeMillis() - 1000 * 60 * 60) < 1000 * 60);
    }


    @Test
    public void testTestApiConnect() throws Exception{
        SeedManager.SeedParser parser = new DefaultSeedParser();

        String randomSeed = randomHex(32);
        Long randomTime = new Random().nextLong();
        String ret = network.getSync(TEST_BASE_URL + String.format("test/%1$s/%2$d",randomSeed,randomTime));
        Seed seed = parser.parse(ret);
        assertEquals(randomSeed, seed.getSeed());
        assertTrue(randomTime == seed.getExpiredTime());
    }
    private static final char[] CHARSET = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    private String randomHex(int length){
        Random ran = new Random();
        StringBuilder sb = new StringBuilder();
        for(int i=0; i<length; i++){
            sb.append(CHARSET[ran.nextInt(CHARSET.length)]);
        }
        return sb.toString();
    }
}