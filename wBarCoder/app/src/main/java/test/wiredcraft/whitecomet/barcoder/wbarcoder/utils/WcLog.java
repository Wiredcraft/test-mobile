package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import android.util.Log;

/**
 * Encapsulation of the android.util.Log.
 * Sse a unified TAG of "WBarcode" and combine the original tag with message
 * @version 0.1 unfinished
 * @author shiyinayuriko
 */
public class WcLog {
    private static final String TAG = "WBarcode";

    /**
     * Encapsulation of Log.i()
     * @param tag the original tag
     * @param msg log message
     */
    public static void i(String tag, String msg){
        Log.i(TAG,combineLog(tag,msg));
    }
    /**
     * Encapsulation of Log.d()
     * @param tag the original tag
     * @param msg log message
     */
    public static void d(String tag, String msg){
        Log.d(TAG,combineLog(tag,msg));
    }
    /**
     * Encapsulation of Log.e()
     * @param tag the original tag
     * @param msg log message
     * @param e exception info
     */
    public static void e(String tag, String msg, Throwable e){
        Log.e(TAG,combineLog(tag,msg), e);
    }

    private static final String TAG_TEST = "WBarcode_test";

    /**
     * used for Android test, with a specific TAG of "WBarcode_test"
     * @param tag the original tag
     * @param msg log message
     */
    public static void test(String tag, String msg){
        Log.e(TAG_TEST,combineLog(tag,msg));
    }
    private static String combineLog(String tag, String msg){
        return String.format("%1$s ===> [%2$s]", tag, msg);
    }
}
