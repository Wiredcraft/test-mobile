package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import android.util.Log;

public class WcLog {
    private static final String TAG = "WBarcode";
    public static void i(String tag, String msg){
        Log.i(TAG,combineLog(tag,msg));
    }
    public static void d(String tag, String msg){
        Log.d(TAG,combineLog(tag,msg));
    }
    public static void e(String tag, String msg, Throwable e){
        Log.e(TAG,combineLog(tag,msg), e);
    }

    private static final String TAG_TEST = "WBarcode_test";
    public static void test(String tag, String msg){
        Log.e(TAG_TEST,combineLog(tag,msg));
    }
    private static String combineLog(String tag, String msg){
        return String.format("%1$s ===> [%2$s]", tag, msg);
    }
}
