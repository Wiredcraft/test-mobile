package com.caizhixng.githubapidemo.base

import android.app.Application

/**
 * Created by caizhixing on 2020/4/3
 */
class App : Application() {

    companion object {
        lateinit var app: Application
    }

    override fun onCreate() {
        super.onCreate()
        app = this
    }
}