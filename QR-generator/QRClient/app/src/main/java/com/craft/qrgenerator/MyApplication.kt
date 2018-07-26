package com.craft.qrgenerator

import android.app.Application
import com.facebook.stetho.Stetho
import com.uuzuche.lib_zxing.activity.ZXingLibrary

class MyApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        // Init ZXing for QR generate and scan
        ZXingLibrary.initDisplayOpinion(this)
        // Init Stetho for network listener
        // input  chrome://inspect  in browser address field
        Stetho.initializeWithDefaults(this)
    }
}