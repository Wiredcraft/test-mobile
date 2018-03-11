package com.seazon.qrgenerator.utils

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.Settings


/**
 * Created by seazon on 2018/3/8.
 */
object CommonUtils {

    /**
     * Return left time(seconds).
     *
     * If expired, return "Expired at XXXX-XX-XXTXX:XX:XX.XXXZ"
     */
    fun showCountdown(countdown: Long): String {
        return if (countdown > 0) {
            (countdown / 1000).toString() + "s"
        } else {
            "Expired"
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