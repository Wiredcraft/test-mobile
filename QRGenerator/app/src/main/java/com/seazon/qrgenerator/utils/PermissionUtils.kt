package com.seazon.qrgenerator.utils

import android.app.Activity
import android.content.DialogInterface
import android.content.pm.PackageManager
import android.os.Build
import android.support.v7.app.AlertDialog
import com.seazon.qrgenerator.R

/**
 * Created by seazon on 2018/3/9.
 */
class PermissionUtils {

    companion object {

        /**
         *  if version < M or granted, do nothing
         *
         *  if user reject grant before, but do not select "Don’t ask again", show alert dialog to grant
         *  else show system request permission dialog
         */
        fun checkPermission(activity: Activity, permission: String, requestCode: Int) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val hasPermission = activity.checkSelfPermission(permission)
                if (hasPermission != PackageManager.PERMISSION_GRANTED) {
                    val shouldShowDialog = activity.shouldShowRequestPermissionRationale(permission)
                    if (shouldShowDialog) {
                        showPermissionAlertDialog(activity, R.string.permission_before_grant,
                                R.string.permission_grant, DialogInterface.OnClickListener { _, _ ->
                            requestPermissions(activity, permission, requestCode)
                        })
                    } else {
                        requestPermissions(activity, permission, requestCode)
                    }
                }
            }
        }

        private fun requestPermissions(activity: Activity, permission: String, requestCode: Int) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                activity.requestPermissions(arrayOf(permission), requestCode)
            }
        }

        /**
         * show alert dialog for user to grant
         */
        private fun showPermissionAlertDialog(activity: Activity, message: Int, btnTitleResId: Int, btnTitleListener: DialogInterface.OnClickListener) {
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
                showPermissionAlertDialog(activity, R.string.permission_after_deny,
                        R.string.permission_grant, DialogInterface.OnClickListener { _, _ ->
                    activity.finish()
                    CommonUtils.openAppDetail(activity, activity.packageName)
                })
            }
        }
    }

}