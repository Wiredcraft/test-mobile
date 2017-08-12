package com.inaction.edward.qrgenerator

import android.app.Application
import com.inaction.edward.qrgenerator.database.AppDatabase

class CustomizedApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        AppDatabase.init(this)
    }

}
