package com.test.aric

import android.app.Application
import com.pluto.Pluto
import com.pluto.plugins.network.PlutoNetworkPlugin
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class GithubApplication : Application(){

    override fun onCreate() {
        super.onCreate()
    Pluto.Installer(this)
    .addPlugin(PlutoNetworkPlugin("network"))
    .install()
    }
}