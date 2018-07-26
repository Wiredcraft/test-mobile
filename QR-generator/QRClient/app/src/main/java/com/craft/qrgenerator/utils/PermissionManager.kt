package com.craft.qrgenerator.utils

import android.app.Activity
import android.content.DialogInterface
import android.content.pm.PackageManager
import android.os.Build
import android.support.annotation.RequiresApi
import android.support.v7.app.AlertDialog
import com.craft.qrgenerator.R


class PermissionManager {

    companion object {

        @RequiresApi(Build.VERSION_CODES.M)
                /**
         *  if version < M or granted, do nothing
         *
         *  if user reject grant before, but do not select "Don’t ask again", show alert dialog to grant
         *  else show system request permission dialog
         */
        fun checkPermission(activity: Activity, permission: String, requestCode: Int) {
            if (isNeedPermissions()) {
                val hasPermission = activity.checkSelfPermission(permission)
                if (hasPermission != PackageManager.PERMISSION_GRANTED) {
                    val shouldShowDialog = activity.shouldShowRequestPermissionRationale(permission)

                    if (shouldShowDialog) {
                        showPermissionDialog(activity, R.string.permission_before_grant,
                                R.string.permission_grant, DialogInterface.OnClickListener { _, _ ->

                            if (isNeedPermissions()) {
                                activity.requestPermissions(arrayOf(permission), requestCode)
                            }
                        })

                    } else {
                        if (isNeedPermissions()) {
                            activity.requestPermissions(arrayOf(permission), requestCode)
                        }
                    }
                }
            }
        }

        /**
         * show alert dialog for user to grant
         */
        private fun showPermissionDialog(activity: Activity, message: Int, btnTitleResId: Int, btnTitleListener: DialogInterface.OnClickListener) {
            val exitAppListener = DialogInterface.OnClickListener { _, _ -> activity.finish() }
            val builder = AlertDialog.Builder(activity)
            builder.setMessage(message)
                    .setPositiveButton(btnTitleResId, btnTitleListener)
                    .setNeutralButton(R.string.permission_exit, exitAppListener)
            val dialog = builder.create()
            dialog.setCanceledOnTouchOutside(false)
            dialog.setOnCancelListener({ activity.finish() })
            dialog.show()
        }

        /**
         * if not grant, show alert dialog for user to open app detail to grant
         * because maybe the system permission dialog won't show again
         */
        fun onRequestPermissionsResult(activity: Activity, grantResults: IntArray) {
            if (grantResults.isEmpty() || grantResults[0] != PackageManager.PERMISSION_GRANTED) {
                showPermissionDialog(activity, R.string.permission_after_deny,
                        R.string.permission_grant, DialogInterface.OnClickListener { _, _ ->
                    activity.finish()
                    AppUtils.openApp(activity, activity.packageName)
                })
            }
        }

        private fun isNeedPermissions(): Boolean {
            return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
        }
    }
}