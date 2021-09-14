package com.example.testmobile

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.testmobile.model.GithubUser

@BindingAdapter("userAvatar")
fun setAvatar(imageView: ImageView, url: String?) {
    Glide.with(imageView)
        .load(url)
        .into(imageView)
}