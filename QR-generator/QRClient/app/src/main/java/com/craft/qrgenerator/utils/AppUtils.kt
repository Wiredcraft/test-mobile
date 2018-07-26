package com.craft.qrgenerator.utils

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import org.joda.time.DateTime
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*

class AppUtils {

    companion object {

        /**
         * open app
         */
        fun openApp(activity: Activity, packageName: String) {
            val intent = Intent()
            intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
            val uri = Uri.fromParts("package", packageName, null)
            intent.data = uri
            activity.startActivity(intent)
        }

        /**
         * get millisecond by date string
         */
        fun dateTolong(strDate: String): Long {
            val str = dateFormat(strDate)
            val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault())
            var time: Long = 0
            try {
                val date = sdf.parse(str)
                time = date.time
            } catch (e: ParseException) {
                e.printStackTrace()
            }

            return time
        }

        private fun dateFormat(date: String): String {
            if (date.indexOf("T") == -1) {
                return date
            }
            val dt5 = DateTime(date)
            return dt5.toString().replace("T", " ").substring(0, 19)
        }

        /**
         * Return Expired time(seconds).
         */
        fun showTime(time: Long): String {
            return if (time > 0) {
                (time / 1000).toString() + "s"
            } else {
                "Expired"
            }
        }

    }
}