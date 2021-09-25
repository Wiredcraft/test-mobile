package com.yxf.mvvmcommon.utils

import android.content.Context
import android.util.Log
import android.widget.Toast
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

object ToastUtils : KoinComponent {

    private val TAG = ToastUtils::class.qualifiedName

    private val context: Context by inject()

    fun shortToast(message: String) {
        showToast(message, Toast.LENGTH_SHORT)
    }

    fun longToast(message: String) {
        showToast(message, Toast.LENGTH_LONG)
    }

    fun showToast(message: String, duration: Int) {
        GlobalScope.launch(Dispatchers.Main) {
            Log.d(TAG, "show toast, message: $message")
            Toast.makeText(context, message, duration).show()
        }
    }
}