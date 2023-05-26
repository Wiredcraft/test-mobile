package com.aric.finalweather

import android.widget.ImageView
import android.widget.TextView
import androidx.databinding.BindingAdapter
import com.aric.finalweather.extentions.setTextHTML
import com.bumptech.glide.Glide


object DataBindingAdapter {
    @JvmStatic
    @BindingAdapter("imageUrl", "isCircle", requireAll = false)
    fun displayImage(iv: ImageView, imageUrl: String, isCircle: Boolean = false) = if (isCircle) {
        Glide.with(iv.context)
            .load(imageUrl)
            .circleCrop()
            .into(iv)
    } else {
        Glide.with(iv.context)
            .load(imageUrl)
            .into(iv)
    }

    @JvmStatic
    @BindingAdapter("html")
    fun textViewHtml(tv: TextView, html: String) = tv.setTextHTML(html)
}