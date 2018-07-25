package com.craft.qrgenerator

import android.app.Application
import com.uuzuche.lib_zxing.activity.ZXingLibrary

class MyApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        ZXingLibrary.initDisplayOpinion(this)
    }
}