package com.seazon.qrgenerator.utils

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.Settings
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

    /**
     * open app detail, for 2.3+
     */
    fun openAppDetail(activity: Activity, packageName: String) {
        val intent = Intent()
        intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
        val uri = Uri.fromParts("package", packageName, null)
        intent.data = uri
        activity.startActivity(intent)
    }

}