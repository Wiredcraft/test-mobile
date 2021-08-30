package com.fly.audio.util

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
/**
 * Created by likainian on 2021/7/13
 * Description:  权限工具类
 */

object PermissionUtil {

    //申请录音权限
    val recodeRequestCode = 1
    val audioPermissions = arrayOf(
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.WRITE_EXTERNAL_STORAGE,
        Manifest.permission.READ_EXTERNAL_STORAGE
    )

    /** 申请录音权限 */
    fun checkAudio(activity:Activity):Boolean {
        val permission = (ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.RECORD_AUDIO
        ) == PackageManager.PERMISSION_GRANTED
            && ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        ) == PackageManager.PERMISSION_GRANTED
            && ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.READ_EXTERNAL_STORAGE
        ) == PackageManager.PERMISSION_GRANTED)
        if (!permission) {
            ActivityCompat.requestPermissions(
                activity, audioPermissions,
                recodeRequestCode
            )
        }
        return permission
    }

    /** 申请录音权限 */
    fun checkRead(activity:Activity):Boolean {
        val permission = (ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.RECORD_AUDIO
        ) == PackageManager.PERMISSION_GRANTED
            && ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        ) == PackageManager.PERMISSION_GRANTED
            && ActivityCompat.checkSelfPermission(
            activity,
            Manifest.permission.READ_EXTERNAL_STORAGE
        ) == PackageManager.PERMISSION_GRANTED)
        if (!permission) {
            ActivityCompat.requestPermissions(
                activity, audioPermissions,
                recodeRequestCode
            )
        }
        return permission
    }
}