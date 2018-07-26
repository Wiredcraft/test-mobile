package com.craft.qrgenerator.utils

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.Settings

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
    }
}