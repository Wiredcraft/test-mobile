package cn.yohack.wildg.utils

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.Transformation
import com.bumptech.glide.load.resource.bitmap.CircleCrop
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder

/**
 * @Author yo_hack
 * @Date 2021.10.13
 * @Description photoLoader
 **/


/**
 * 加载图片
 */
@SuppressLint("CheckResult")
fun loadImg(
    context: Context?,
    iv: ImageView?,
    model: Any?,
    transform: Transformation<Bitmap>?,
    placeHolder: Int = 0,
    errorHolder: Int = placeHolder
) {
    if (context == null || iv == null) {
        return
    }
    Glide.with(context)
        .load(model)
        .apply {
            if (placeHolder != 0) {
                placeholder(placeHolder)
            }

            if (errorHolder != 0) {
                error(errorHolder)
            }

            transform?.let {
                transform(it)
            }
        }
        .into(iv)
}

/**
 * 加载图片
 */
@SuppressLint("CheckResult")
fun loadImg(
    context: Context?,
    iv: ImageView?,
    model: Any?,
    transform: Transformation<Bitmap>?,
    placeHolder: Drawable? = null,
    errorHolder: Drawable? = placeHolder
) {
    if (context == null || iv == null) {
        return
    }
    Glide.with(context)
        .load(model)
        .apply {
            if (placeHolder != null) {
                placeholder(placeHolder)
            }

            if (errorHolder != null) {
                error(errorHolder)
            }

            transform?.let {
                transform(it)
            }
        }
        .into(iv)
}


/**
 * 加载圆形图片
 */
fun loadCircle(
    context: Context?,
    iv: ImageView,
    model: Any?,
    placeHolder: Int = 0,
    errorHolder: Int = placeHolder
) {
    loadImg(context, iv, model, CircleCrop(), placeHolder, errorHolder)
}


/**
 * 加载圆形图片
 */
fun loadCircle(
    context: Context?,
    iv: ImageView,
    model: Any?,
    placeHolder: Drawable? = null,
    errorHolder: Drawable? = placeHolder
) {
    loadImg(context, iv, model, CircleCrop(), placeHolder, errorHolder)
}


fun ImageView.loadCircle(
    model: Any?,
    placeHolder: Int = 0,
    errorHolder: Int = placeHolder
) {
    loadCircle(this.context, this, model, placeHolder, errorHolder)
}

fun ImageView.loadCircle(
    model: Any?,
    placeHolder: Drawable? = null,
    errorHolder: Drawable? = placeHolder
) {
    loadCircle(this.context, this, model, placeHolder, errorHolder)
}

fun BaseViewHolder.loadCircle(
    resId: Int, model: Any?, placeHolder: Int = 0, errorHolder: Int = placeHolder
) {
    getView<ImageView>(resId).loadCircle(model, placeHolder, errorHolder)
}