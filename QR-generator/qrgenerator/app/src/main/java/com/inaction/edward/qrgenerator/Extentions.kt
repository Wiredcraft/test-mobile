package com.inaction.edward.qrgenerator

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.widget.Toast

fun Context.toast(message: String) =
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
fun Context.toast(resourceId: Int) = toast(getString(resourceId))

fun Activity.toActivity(activityClass: Class<*>) = startActivity(Intent(this, activityClass))
