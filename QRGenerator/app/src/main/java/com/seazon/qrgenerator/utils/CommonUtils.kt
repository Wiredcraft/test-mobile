package com.seazon.qrgenerator.utils

import java.text.SimpleDateFormat
import java.util.*


/**
 * Created by seazon on 2018/3/8.
 */
object CommonUtils {

    private val SDF = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")

    /**
     * Return left time(seconds).
     *
     * If expired, return "Expired at XXXX-XX-XXTXX:XX:XX.XXXZ"
     */
    fun showCountdown(expireTime: Long): String {
        val countdown = expireTime - System.currentTimeMillis()
        return if (countdown > 0) {
            (countdown / 1000).toString() + "s"
        } else {
            "Expired at " + SDF.format(Date(expireTime))
        }
    }

}