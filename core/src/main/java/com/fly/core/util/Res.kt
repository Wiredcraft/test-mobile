package com.fly.core.util

import android.content.Context
import android.content.res.Resources
import android.graphics.drawable.Drawable
import androidx.annotation.ArrayRes
import androidx.annotation.ColorRes
import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.core.content.ContextCompat
import com.fly.core.base.appContext

/**
 * Created by likainian on 2021/7/13
 * Description:  res工具类
 */

object Res {

    fun getString(@StringRes id: Int, context: Context = appContext): String =
        context.resources.getString(id)

    fun getStringArray(
        @ArrayRes id: Int,
        context: Context = appContext
    ): Array<String> = context.resources.getStringArray(id)

    fun getDrawable(
        @DrawableRes id: Int,
        context: Context = appContext
    ): Drawable? = ContextCompat.getDrawable(context, id)

    fun getColor(@ColorRes id: Int, context: Context = appContext): Int =
        ContextCompat.getColor(context, id)


    fun px2dp(pxValue: Float): Int {
        val scale = Resources.getSystem().displayMetrics.density
        return (pxValue / scale + 0.5f).toInt()
    }

    fun dp2px(dpValue: Float): Int {
        val scale = Resources.getSystem().displayMetrics.density
        return (dpValue * scale + 0.5f).toInt()
    }
}