package com.yuan.qrclient;

import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.util.DisplayMetrics;
import android.view.WindowManager;

import com.squareup.leakcanary.LeakCanary;
import com.squareup.leakcanary.RefWatcher;

/**
 * Created by Yuan on 16/1/15.
 */
public class QRApp extends Application {
    private static QRApp ourInstance;

    private RefWatcher refWatcher;

    public static QRApp getInstance() {
        return ourInstance;
    }

    public static RefWatcher refWatcher(Context context){
        QRApp application = (QRApp)context.getApplicationContext();
        return application.refWatcher;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        refWatcher = LeakCanary.install(this);
        ourInstance = this;
        buildUserAgent();
    }

    private String buildUserAgent() {
        DisplayMetrics metrics = new DisplayMetrics();
        WindowManager wm = (WindowManager) getSystemService(WINDOW_SERVICE);
        wm.getDefaultDisplay().getMetrics(metrics);
        return String.format("QRClient %s Android (%d/%s; %d; %dx%d)",
                BuildConfig.VERSION_NAME,
                Build.VERSION.SDK_INT, Build.VERSION.RELEASE,
                metrics.densityDpi, metrics.widthPixels, metrics.heightPixels);
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
    }

    @Override
    public void onTrimMemory(int level) {
        super.onTrimMemory(level);
    }
}
