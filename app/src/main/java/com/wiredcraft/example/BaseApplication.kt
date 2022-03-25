package com.wiredcraft.example

import com.wiredcraft.example.config.GlobalSettings.init
import android.app.Application
import com.blankj.utilcode.util.Utils

class BaseApplication internal constructor() : Application() {
    companion object {
        lateinit var instance: BaseApplication
    }

    /**
     * 初始化GlobalSetting
     */
    override fun onCreate() {
        super.onCreate()
        instance = this
        Utils.init(this)
    }

    init {
        instance = this
        init()
    }
}