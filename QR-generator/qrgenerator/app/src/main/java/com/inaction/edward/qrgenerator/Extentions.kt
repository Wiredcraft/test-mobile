package com.inaction.edward.qrgenerator

import android.app.Activity
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.widget.Toast

fun Context.toast(message: String) =
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
fun Context.toast(resourceId: Int) = toast(getString(resourceId))

fun Activity.toActivity(activityClass: Class<*>) = startActivity(Intent(this, activityClass))

fun Context.addClip(message: String) {
    val clipData: ClipData = ClipData.newPlainText("seed", message)
    val clipboardManager = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager

    clipboardManager.primaryClip = clipData
}
