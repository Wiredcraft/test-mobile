package com.aric.finalweather

import android.app.Application
import com.pluto.Pluto
import com.pluto.plugins.network.PlutoNetworkPlugin

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        Pluto.Installer(this)
            .addPlugin(PlutoNetworkPlugin("network"))
            .install()
    }
}