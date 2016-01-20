package com.yuan.qrclient.utils;

import android.util.Log;

import com.yuan.qrclient.BuildConfig;

/**
 * Created by Yuan on 16/1/15.
 */
public class QLog {

    public static final String TAG = "com.yuan.qrclient";

    public static final boolean DEBUG = BuildConfig.DEBUG;


    /**
     * android log for level d
     *
     * @param log
     * @return
     */
    public static int d(String log){
        if(DEBUG)
            return Log.d(TAG,log);
        return -1;
    }

    /**
     * android log for level e
     *
     * @param log
     * @return
     */
    public static int e(String log){
        if(DEBUG)
            return Log.e(TAG, log);
        return -1;
    }

    /**
     * android log for level i
     *
     * @param log
     * @return
     */
    public static int i(String log){
        if(DEBUG)
            return Log.i(TAG, log);
        return -1;
    }

    /**
     * android log for level w
     *
     * @param log
     * @return
     */
    public static int w(String log){
        if(DEBUG)
            return Log.w(TAG, log);
        return -1;
    }
}
