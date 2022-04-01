package www.wiredcraft.testmobile.widget

import android.content.Context
import android.content.res.Resources
import android.graphics.*
import com.bumptech.glide.load.engine.bitmap_recycle.BitmapPool
import com.bumptech.glide.load.resource.bitmap.BitmapTransformation
import java.security.MessageDigest

/**
 *@Description:
 * #构造函数 默认圆角半径 4dp
 *
 * @param context Context
 * @param dp 圆角半径
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class GlideRoundTransform @JvmOverloads constructor(
    context: Context?,
    dp: Int = 4
) : BitmapTransformation() {
    override fun transform(
        pool: BitmapPool,
        toTransform: Bitmap,
        outWidth: Int,
        outHeight: Int
    ): Bitmap {
        return roundCrop(pool, toTransform)!!
    }

    init {
        radius =
            Resources.getSystem().displayMetrics.density * dp
    }

    override fun updateDiskCacheKey(messageDigest: MessageDigest) {}

    companion object {
        private var radius = 0f
        private fun roundCrop(pool: BitmapPool, source: Bitmap?): Bitmap? {
            if (source == null) return null
            val result =
                pool[source.width, source.height, Bitmap.Config.ARGB_8888]
            val canvas = Canvas(result)
            val paint = Paint()
            paint.shader = BitmapShader(
                source,
                Shader.TileMode.CLAMP,

                Shader.TileMode.CLAMP
            )
            paint.isAntiAlias = true
            val rectF = RectF(
                0f, 0f, source.width.toFloat(), source.height
                    .toFloat()
            )
            canvas.drawRoundRect(
                rectF,
                radius,
                radius,
                paint
            )
            return result
        }
    }

}
