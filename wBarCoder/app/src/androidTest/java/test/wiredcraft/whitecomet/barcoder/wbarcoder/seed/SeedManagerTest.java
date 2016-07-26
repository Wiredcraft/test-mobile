package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.test.InstrumentationRegistry;
import android.support.v7.internal.view.menu.MenuWrapperFactory;
import android.test.suitebuilder.annotation.LargeTest;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.Random;
import java.util.concurrent.CountDownLatch;
import java.util.prefs.Preferences;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.Seed;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.seed.SeedManager;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Constant;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Network;

import static org.junit.Assert.*;

@LargeTest
public class SeedManagerTest {

    private SeedManager manager;
    private static final String TEST_BASE_URL = Constant.SERVER_HOST;
    private Context context;

    @Before
    public void setUp() throws Exception {
        context = InstrumentationRegistry.getTargetContext();
        manager = SeedManager.getInstance(context);
        manager.setSeedUrl(TEST_BASE_URL);
    }

    @Test
    public void testRefreshSeed() throws Exception {
        final CountDownLatch signal = new CountDownLatch(1);
        final Seed seed = new Seed(randomHex(32),new Random().nextLong());
        manager.setSeedUrl(TEST_BASE_URL + String.format("test/%1$s/%2$d",seed.getSeed(), seed.getExpiredTime()));

        manager.registerRefreshCallback(new SeedManager.SeedRefreshedCallback() {
            @Override
            public void onRefresh(Seed newSeed) {
                Assert.assertEquals(seed,newSeed);
                signal.countDown();
            }
        });
        manager.refreshSeed();
        signal.await();
    }
    @Test
    public void testSaveSeed() throws Exception {
        final Seed seed = new Seed(randomHex(32),new Random().nextLong());
        manager.saveSeed(seed);

        synchronized (manager){
            SharedPreferences pref = context.getSharedPreferences("pref_seed", Context.MODE_PRIVATE);
            assertEquals(seed.getSeed(), pref.getString("seed",null));
            assertTrue(seed.getExpiredTime() == pref.getLong("expired_time", -1));
        }
    }

    @Test
    public void testLoadSeed() throws Exception {
        final Seed seed = new Seed(randomHex(32),new Random().nextLong());;

        manager.saveSeed(seed);
        Seed newSeed = manager.loadSeed();

        assertEquals(seed, newSeed);
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