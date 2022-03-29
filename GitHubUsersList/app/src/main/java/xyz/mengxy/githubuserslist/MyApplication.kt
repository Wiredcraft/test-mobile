package xyz.mengxy.githubuserslist

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

/**
 * Created by Mengxy on 3/28/22.
 * All apps that use Hilt must contain an Application class that is annotated with @HiltAndroidApp.
 */
@HiltAndroidApp
class MyApplication: Application()