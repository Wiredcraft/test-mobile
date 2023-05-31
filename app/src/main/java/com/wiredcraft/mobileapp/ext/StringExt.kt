package com.wiredcraft.mobileapp.ext

import android.content.Context
import android.widget.Toast

/**
 * Extend Toast for String
 */
fun String.toastLong(context: Context) = Toast.makeText(context, this, Toast.LENGTH_LONG).show()