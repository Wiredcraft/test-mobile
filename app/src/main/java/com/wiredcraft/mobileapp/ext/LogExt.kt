package com.wiredcraft.mobileapp.ext

import android.util.Log
import com.wiredcraft.mobileapp.BuildConfig

private const val DEFAULT_TAG = BuildConfig.APPLICATION_ID

/**
 * Extend the log method to print info level logs
 */
fun Any.logInfo(tag: String? = null) {
    if (BuildConfig.LOG_SWITCH) {
        Log.i(tag ?: DEFAULT_TAG, this.toString())
    }
}


/**
 * Extend the log method to print debug level logs
 */
fun Any.logDebug(tag: String? = null) {
    if (BuildConfig.LOG_SWITCH) {
        Log.d(tag ?: DEFAULT_TAG, this.toString())
    }
}


/**
 * Extend the log method to print warning level logs
 */
fun Any.logWarning(tag: String? = null) {
    if (BuildConfig.LOG_SWITCH) {
        Log.w(tag ?: DEFAULT_TAG, this.toString())
    }
}


/**
 * Extend the log method to print error level logs
 */
fun Any.logError(tag: String? = null) {
    if (BuildConfig.LOG_SWITCH) {
        Log.e(tag ?: DEFAULT_TAG, this.toString())
    }
}