package com.fly.core.util

import android.util.Log
import com.fly.core.BuildConfig

/**
 * Created by likainian on 2021/7/15
 * Description:日志打印（分段）
 */

object LogUtil {
    fun i(message: String) {
        if (BuildConfig.DEBUG) {
            log(generateTag(), message)
        }
    }

    fun i(tag: String, message: String) {
        if (BuildConfig.DEBUG) {
            log(tag, message)
        }
    }

    private fun generateTag(): String {
        val sElements = Throwable().stackTrace[2]
        val className = sElements.fileName
        val methodName = sElements.methodName
        val lineNumber = sElements.lineNumber
        return String.format("%s:%s(%s:%d)", className, methodName, className, lineNumber)
    }

    private fun log(tag: String?, msg: String) {
        var msg = msg
        if (tag == null || tag.isEmpty() || msg.isEmpty()) return
        val segmentSize = 3 * 1024
        val length = msg.length.toLong()
        if (length <= segmentSize) {// 长度小于等于限制直接打印
            Log.i(tag, msg)
        } else {
            while (msg.length > segmentSize) {// 循环分段打印日志
                val logContent = msg.substring(0, segmentSize)
                msg = msg.substring(segmentSize, msg.length)
                Log.i(tag, logContent)
            }
            Log.i(tag, msg)// 打印剩余日志
        }
    }
}