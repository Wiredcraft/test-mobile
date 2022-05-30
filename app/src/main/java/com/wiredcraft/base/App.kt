package com.wiredcraft.base

import android.app.Application
import com.facebook.drawee.backends.pipeline.Fresco
import com.wiredcraft.database.AppDatabase
import com.wiredcraft.network.RetrofitUtil

class App : Application() {

    override fun onCreate() {
        super.onCreate()
        Fresco.initialize(this)
        AppDatabase.initialize(this)
        RetrofitUtil.initialize()
    }
}