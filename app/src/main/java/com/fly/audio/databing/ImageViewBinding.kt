package com.fly.audio.databing

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.fly.audio.R

object ImageViewBinding {
    private const val IMAGE_URL_AVATAR = BINDING_PREFIX + "image_url_avatar"

    @JvmStatic
    @BindingAdapter(value = [IMAGE_URL_AVATAR])
    fun loadImage(imageView: ImageView, url: String?) {
        if (url.isNullOrEmpty()) {
            imageView.setImageResource(R.drawable.ic_loading)
        } else {
            Glide.with(imageView)
                .load(url)
                .placeholder(R.drawable.ic_loading)
                .error(R.drawable.ic_loading)
                .into(imageView)
        }
    }
}
