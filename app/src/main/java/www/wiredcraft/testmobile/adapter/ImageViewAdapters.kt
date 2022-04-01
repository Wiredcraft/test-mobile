package www.wiredcraft.testmobile.adapter

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import www.wiredcraft.testmobile.widget.GlideRoundTransform

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
object ImageViewAdapters {

    @JvmStatic
    @BindingAdapter("imageUrl")
    fun ImageView.setImageUrl(url: String?) {
        Glide.with(context.applicationContext)
            .load(url)
            //.placeholder(R.drawable.ic_launcher_background)
            .transform(CenterCrop(), GlideRoundTransform(context.applicationContext,50))
            .transition(DrawableTransitionOptions.withCrossFade(500))
            .into(this)
    }
}