package com.andzhv.githubusers

import android.app.Application

/**
 * Created by zhaowei on 2021/9/10.
 */
class GithubApplication : Application() {
    companion object {
        lateinit var context: Application
    }

    override fun onCreate() {
        super.onCreate()
        context = this
    }
}