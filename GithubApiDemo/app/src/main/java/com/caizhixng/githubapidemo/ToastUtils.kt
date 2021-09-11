package com.caizhixng.githubapidemo

import android.content.Context
import android.util.Log
import android.view.Gravity
import android.widget.Toast
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * Created by caizhixing on 2020/4/24
 */
object ToastUtils {

    @Volatile
    var toast: Toast? = null

    @Synchronized
    suspend fun Context.toastOnMainThread(message: String) {
        withContext(Dispatchers.Main) {
            toast?.cancel()
            toast = Toast.makeText(this@toastOnMainThread, message, Toast.LENGTH_SHORT)
            toast!!.setGravity(Gravity.CENTER, 0, 0)
            toast!!.show()
        }
    }

    @Synchronized
    fun Context.toast(message: String) {
        if (toast != null) {
            toast!!.cancel()
        }
        try {
            toast = Toast.makeText(this, message, Toast.LENGTH_SHORT)
            toast!!.setGravity(Gravity.CENTER, 0, 0)
            toast!!.show()
        } catch (e: Exception) {
            Log.e("toast", Log.getStackTraceString(e))
        }
    }
}