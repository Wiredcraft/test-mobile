package com.dorck.githuber

import android.content.Context
import com.bumptech.glide.GlideBuilder
import com.bumptech.glide.annotation.GlideModule
import com.bumptech.glide.module.AppGlideModule

/** Ensures that Glide's generated API is created for the Gallery sample.  */
@GlideModule
class SimpleGlideModule : AppGlideModule() {
    override fun applyOptions(context: Context, builder: GlideBuilder) {
        super.applyOptions(context, builder)
        builder.setIsActiveResourceRetentionAllowed(true)
    }
}