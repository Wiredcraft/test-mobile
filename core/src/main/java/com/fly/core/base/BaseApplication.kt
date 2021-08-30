package com.fly.core.base

import android.app.Application
/**
 * Created by likainian on 2021/7/13
 * Description:  基础app
 */

open class BaseApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        appContext = this
    }
}

lateinit var appContext: Application