package com.fly.audio.ext

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.media.ExifInterface
import android.util.Base64
import android.widget.Toast
import com.fly.core.base.appContext
import java.io.IOException
import java.nio.charset.Charset
import java.util.*
import java.util.regex.Pattern
import kotlin.math.pow

/**
 * Created by likainian on 2021/7/13
 * Description:  string工具类
 */

/**
 * 根据图片绝对路径，查看该图片是否旋转过
 */
fun String.readPictureDegree(): Int {
    var degree = 0
    try {
        val exifInterface = ExifInterface(this)
        when (exifInterface.getAttributeInt(
            ExifInterface.TAG_ORIENTATION,
            ExifInterface.ORIENTATION_NORMAL
        )) {
            ExifInterface.ORIENTATION_ROTATE_90,
            ExifInterface.ORIENTATION_TRANSPOSE -> degree = 90
            ExifInterface.ORIENTATION_ROTATE_180,
            ExifInterface.ORIENTATION_FLIP_VERTICAL -> degree = 180
            ExifInterface.ORIENTATION_ROTATE_270,
            ExifInterface.ORIENTATION_TRANSVERSE -> degree = 270
        }
    } catch (e: IOException) {
        e.printStackTrace()
    }

    return degree
}

fun String.readExifTranslation(): Float {
    val exifInterface = ExifInterface(this)
    val orientation = exifInterface.getAttributeInt(
        ExifInterface.TAG_ORIENTATION,
        ExifInterface.ORIENTATION_NORMAL
    )
    var translation = 0f
    translation = when (orientation) {
        ExifInterface.ORIENTATION_FLIP_HORIZONTAL,
        ExifInterface.ORIENTATION_FLIP_VERTICAL,
        ExifInterface.ORIENTATION_TRANSPOSE,
        ExifInterface.ORIENTATION_TRANSVERSE ->
            -1f
        else ->
            1f
    }
    return translation
}

fun String.toDimensionality(): Double {
    var dimensionality = 0.0
    val split = split(",".toRegex()).toTypedArray()
    for (i in split.indices) {
        val s = split[i].split("/".toRegex()).toTypedArray()
        val v = s[0].toDouble() / s[1].toDouble()
        dimensionality += v / 60.0.pow(i.toDouble())
    }
    return dimensionality
}

fun String.append(any: Any?): String = StringBuilder(this).append(any).toString()

fun String?.copyToClipboard(context: Context) {
    val cm: ClipboardManager =
        context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
    val clipData: ClipData = ClipData.newPlainText("Label", this ?: "")
    cm.setPrimaryClip(clipData)
}

fun String?.toast() {
    this?.let {
        Toast.makeText(appContext,it,Toast.LENGTH_LONG).show()
    }
}

fun String.encodeBase64(): String {
    return if (this.toByteArray().isEmpty()) {
        this
    } else {
        Base64.encode(this.toByteArray(), Base64.URL_SAFE or Base64.NO_WRAP)
            .toString(Charset.defaultCharset())
    }
}

fun String.splitOutNumber(): String? {
    var str: String? = this
    if (str == null) {
        return null
    } else {
        var pattern = Pattern.compile("(\\d+\\.\\d+)")
        var matcher = pattern.matcher(str)
        if (matcher.find()) {
            str = if (matcher.group(1) == null) "" else matcher.group(1)
        } else {
            pattern = Pattern.compile("(\\d+)")
            matcher = pattern.matcher(str)
            str = if (matcher.find()) {
                if (matcher.group(1) == null) "" else matcher.group(1)
            } else {
                ""
            }
        }
        return str
    }
}

/**
 * 首字母转大写
 */
fun String.firstToUpperCase(): String {
    val str: String = this
    if (str.isNotEmpty()) {
        return str.substring(0, 1).toUpperCase(Locale.ROOT) + str.substring(1)
    }
    return ""
}

/**
 * 首字母转小写
 */
fun String.firstToLowerCase(): String {
    val str: String = this
    if (str.isNotEmpty()) {
        return str.substring(0, 1).toLowerCase(Locale.ROOT) + str.substring(1)
    }
    return ""
}

fun String?.isNullOrEmptyOrBlank(): Boolean =
    this == null || this.isEmpty() || this.isBlank()

fun String.nameNomalised(): String =
    split(",").reversed().map { it.trim() }.joinToString(separator = " ") { it }

/**
 * 以空格替换下划线
 */
fun String.replaceUnderline(): String =
    split("_").map { it.trim() }.joinToString(separator = " ") { it }

fun String.limitTextLength(maxLen: Int): String {
    if (isEmpty()) {
        return this
    }
    var count = 0
    var endIndex = 0
    forEachIndexed { index, c ->
        count += if (c.toInt() < 128) {
            1
        } else {
            2
        }
        if (maxLen == count || (c.toInt() >= 128 && maxLen + 1 == count)) {
            endIndex = index
        }
    }
    return if (count <= maxLen) {
        this.plus("    ")
    } else {
        substring(0, endIndex).plus("...    ")
    }
}
