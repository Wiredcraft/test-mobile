package cn.yohack.wildg

import android.app.Application

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description application
 **/
class App : Application() {

    companion object {
        lateinit var app: App
    }

    override fun onCreate() {
        app = this
        super.onCreate()
    }

}