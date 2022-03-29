package xyz.mengxy.githubuserslist.adapter

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CircleCrop
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import com.bumptech.glide.request.RequestOptions
import xyz.mengxy.githubuserslist.R

/**
 * Created by Mengxy on 3/29/22.
 */

@BindingAdapter("imageFromUrl")
fun ImageView.bindImageFromUrl(imageUrl: String?) {
    if (imageUrl.isNullOrEmpty().not()) {
        Glide.with(context).load(imageUrl)
            .transition(DrawableTransitionOptions.withCrossFade())
            .apply(RequestOptions.bitmapTransform(CircleCrop()))
            .placeholder(R.mipmap.ic_avatar_default)
            .error(R.mipmap.ic_avatar_default).into(this)
    }
}