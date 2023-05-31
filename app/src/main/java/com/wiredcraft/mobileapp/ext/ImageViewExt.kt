package com.wiredcraft.mobileapp.ext

import android.app.Activity
import android.content.Context
import android.graphics.drawable.Drawable
import android.view.View
import android.widget.ImageView
import androidx.annotation.DrawableRes
import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.bumptech.glide.Glide
import com.bumptech.glide.load.MultiTransformation
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.CircleCrop

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: Use Glide to extend ImageView
 *
 */



/**
 * ImageView圆形
 */
fun ImageView.circle(view: View, res: Any?) {
    if (!isInLifecycle(view.context)) {
        return
    }
    Glide.with(view)
        .load(res)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}


/**
 * ImageView圆形
 */
fun ImageView.circle(view: View, @IdRes @DrawableRes placeHolder: Int, res: Any?) {
    if (!isInLifecycle(view.context)) {
        return
    }
    Glide.with(view)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}


/**
 * ImageView圆形
 */
fun ImageView.circle(view: View, placeHolder: Drawable, res: Any?) {
    if (!isInLifecycle(view.context)) {
        return
    }
    Glide.with(view)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}


/**
 * ImageView圆形
 */
fun ImageView.circle(fragment: Fragment, @IdRes @DrawableRes placeHolder: Int, res: Any?) {
    if (!isInLifecycle(fragment.context)) {
        return
    }
    Glide.with(fragment)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(fragment: Fragment, placeHolder: Drawable, res: Any?) {
    if (!isInLifecycle(fragment.context)) {
        return
    }
    Glide.with(fragment)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(activity: Activity, @IdRes @DrawableRes placeHolder: Int, res: Any?) {
    if (!isInLifecycle(activity)) {
        return
    }
    Glide.with(activity)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(activity: Activity, placeHolder: Drawable, res: Any?) {
    if (!isInLifecycle(activity)) {
        return
    }
    Glide.with(activity)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(context: Context, @IdRes @DrawableRes placeHolder: Int, res: Any?) {
    if (!isInLifecycle(context)) {
        return
    }
    Glide.with(context)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(context: Context, placeHolder: Drawable, res: Any?) {
    if (!isInLifecycle(context)) {
        return
    }
    Glide.with(context)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}


/**
 * ImageView圆形
 */
fun ImageView.circle(
    fragmentActivity: FragmentActivity,
    @IdRes @DrawableRes placeHolder: Int,
    res: Any?,
) {
    if (!isInLifecycle(fragmentActivity)) {
        return
    }
    Glide.with(fragmentActivity)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}

/**
 * ImageView圆形
 */
fun ImageView.circle(fragmentActivity: FragmentActivity, placeHolder: Drawable, res: Any?) {
    if (!isInLifecycle(fragmentActivity)) {
        return
    }
    Glide.with(fragmentActivity)
        .load(res)
        .placeholder(placeHolder)
        .transform(MultiTransformation(CenterCrop(), CircleCrop()))
        .into(this)
}


/**
 * check lifecycle
 */
fun isInLifecycle(context: Context?) = when(context) {
    is Activity -> {
        !(context.isDestroyed || context.isFinishing)
    }
    else -> {
        true
    }
}