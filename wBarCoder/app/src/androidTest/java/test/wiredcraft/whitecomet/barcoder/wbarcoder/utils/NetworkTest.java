package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import android.test.suitebuilder.annotation.LargeTest;

import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Constant;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Network;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

@LargeTest
public class NetworkTest {
    private static final String TEST_BASE_URL = Constant.SERVER_HOST;

    private Network network;
    @Before
    public void setUp() throws Exception {
        network = new Network();
    }

    @Test
    public void testNetworkConnect()throws Exception{
        String ret = network.getSync("http://baidu.com");
        assertTrue(ret != null);
    }

    @Test
    public void testGetSync() throws Exception {
        String ret = network.getSync(TEST_BASE_URL + "test/abc/def");
        assertEquals("{\"seed\":\"abc\",\"expiredTime\":\"def\"}", ret);
    }

    @Test
    public void testGetAsync() throws Exception {
        final CountDownLatch signal = new CountDownLatch(1);
        network.getAsync(TEST_BASE_URL + "test/abc/def", new Network.GetAsyncCallback() {
            @Override
            public void onResponse(String string, IOException e) {
                assertTrue(e == null);
                assertEquals("{\"seed\":\"abc\",\"expiredTime\":\"def\"}", string);
                signal.countDown();
            }
        });
        signal.await();
    }
}