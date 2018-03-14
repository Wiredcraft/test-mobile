package com.seazon.qrgenerator

import android.app.Application
import com.uuzuche.lib_zxing.activity.ZXingLibrary

/**
 * Created by seazon on 2018/3/7.
 */
class BaseApplication : Application() {

    companion object {
        const val HOST_URL = "http://192.168.31.115:3000"
    }

    override fun onCreate() {
        super.onCreate()
        ZXingLibrary.initDisplayOpinion(this)
    }

}