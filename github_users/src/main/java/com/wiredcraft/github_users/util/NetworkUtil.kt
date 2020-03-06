package com.wiredcraft.testmoblie.util

import android.content.Context
import android.net.ConnectivityManager

/**
 * 网络工具类
 * @author Bruce
 * @date 2020/3/5
 */
object NetworkUtil {

    /**
     * 判断网络是否可用
     * @param context
     * @return
     */
    fun isNetworkAvailable(context: Context): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        return activeNetworkInfo != null && activeNetworkInfo.isConnected
    }
}