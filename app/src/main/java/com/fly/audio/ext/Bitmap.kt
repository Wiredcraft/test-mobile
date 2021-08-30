@file:Suppress("unused")

package com.fly.audio.ext

import android.content.Context
import android.graphics.*
import android.os.Build
import android.renderscript.Allocation
import android.renderscript.Element
import android.renderscript.RenderScript
import android.renderscript.ScriptIntrinsicBlur
import android.util.Base64
import androidx.annotation.FloatRange
import androidx.annotation.IntRange
import androidx.core.graphics.applyCanvas
import com.fly.core.base.appContext
import com.fly.core.util.Screen
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

const val MAX_DOUBLE = Int.MAX_VALUE.toDouble()
const val MIN_DOUBLE = 1.0
/**
 * Created by likainian on 2021/7/13
 * Description:  bitmap工具类
 */

/**
 * 旋转图片，使图片保持正确的方向。
 *
 * @param degrees    要旋转的角度
 * @param isVertical 垂直显示图片
 * @return 旋转后的图片
 */
fun Bitmap.rotate(@IntRange(from = 0, to = 360) degrees: Int, isVertical: Boolean): Bitmap {
    var needRotate = false
    if (isVertical) {
        if (height < width) {
            needRotate = true
        }
    } else {
        if (height > width) {
            needRotate = true
        }
    }

    return if (needRotate) {
        rotate(degrees)
    } else {
        this
    }
}

/**
 * 旋转图片
 *
 * @param degrees
 * @return 不可变的图片
 */
fun Bitmap.rotate(@IntRange(from = 0, to = 360) degrees: Int): Bitmap {
    if (degrees == 0) {
        return this
    }

    val matrix = Matrix()
    matrix.setRotate(degrees.toFloat())

    /**
     * 不建议使用系统的createScaleBitmap, 不是最清晰的
     */
    return Bitmap.createBitmap(this, 0, 0, width, height, matrix, true)
}

/**
 * 旋转图片有效
 */
fun Bitmap.rotateBitmap(path: String): Bitmap {
    val degree = path.readPictureDegree()
    val translation = path.readExifTranslation()
    val w = this.width
    val h = this.height
    val mtx = Matrix()
    mtx.preRotate(degree.toFloat())
    mtx.postScale(translation, 1f)
    return Bitmap.createBitmap(this, 0, 0, w, h, mtx, true)
}

/**
 * 根据宽高缩放, 返回的图片是可变的, 可装载入Canvas
 *
 * @param w   目标宽
 * @param h   目标高
 * @return
 */
fun Bitmap.resize(
    @FloatRange(from = MIN_DOUBLE, to = MAX_DOUBLE) w: Float, @FloatRange(from = MIN_DOUBLE, to = MAX_DOUBLE) h: Float): Bitmap {
    val scaleW = w / width
    val scaleH = h / height

    val matrix = Matrix()
    matrix.setScale(scaleW, scaleH)

    return copy(w, h, matrix)
}

fun Bitmap.resize(
    @IntRange(from = 1, to = Long.MAX_VALUE) w: Int, @IntRange(from = 1, to = Long.MAX_VALUE) h: Int): Bitmap {
    val scaleW = w / width.toFloat()
    val scaleH = h / height.toFloat()

    val matrix = Matrix()
    matrix.setScale(scaleW, scaleH)

    return copy(w, h, matrix)
}

/**
 * 根据比例缩放, 返回的图片是可变的, 可装载入Canvas
 *
 * @param scale
 * @return
 */
fun Bitmap.resize(@FloatRange(from = MIN_DOUBLE, to = MAX_DOUBLE) scale: Float): Bitmap {
    var w = width * scale
    var h = height * scale

    if (w < MIN_DOUBLE) {
        w = MIN_DOUBLE.toFloat()
    }

    if (h < MIN_DOUBLE) {
        h = MIN_DOUBLE.toFloat()
    }

    return copy(w, h, Matrix().apply { setScale(scale, scale) })
}

/**
 * 同时缩放和旋转
 *
 * @param scale  比例
 * @param degree 角度
 * @return 不可变的图片(如果角度为0, scale为1, 那么返回的就是原图)
 */
fun Bitmap.resize(
    @FloatRange(from = MIN_DOUBLE, to = MAX_DOUBLE) scale: Float, @IntRange(from = 0, to = 360) degree: Int): Bitmap {

    val matrix = Matrix()
    matrix.preScale(scale, scale)
    matrix.postRotate(degree.toFloat())

    return Bitmap.createBitmap(this, 0, 0, width, height, matrix, true)
}

/**
 * 根据[matrix]复制一张图片
 */
fun Bitmap.copy(
    w: Int, h: Int, matrix: Matrix, config: Bitmap.Config = Bitmap.Config.ARGB_8888): Bitmap {
    return Bitmap.createBitmap(w, h, config).applyCanvas {
        drawBitmap(this@copy, matrix, null)
    }
}

fun Bitmap.copy(
    w: Float, h: Float, matrix: Matrix, config: Bitmap.Config = Bitmap.Config.ARGB_8888): Bitmap {
    return copy(w.toInt(), h.toInt(), matrix, config)
}

fun Bitmap.copy(config: Bitmap.Config = Bitmap.Config.ARGB_8888): Bitmap {
    return copy(config, true)
}

fun Bitmap.getAlphaSafeConfig(): Bitmap.Config {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        // Avoid short circuiting the sdk check.
        if (Bitmap.Config.RGBA_F16 == config) { // NOPMD
            return Bitmap.Config.RGBA_F16
        }
    }

    return Bitmap.Config.ARGB_8888
}

/**
 * 转换成圆形图片
 */
fun Bitmap.toCircle(): Bitmap {
    val paint = Paint()
    paint.isAntiAlias = true

    val w = width
    val h = height
    val min = if (w > h) h else w

    return Bitmap.createBitmap(min, min, Bitmap.Config.ARGB_8888).applyCanvas {
        drawCircle(min / 2f, min / 2f, min / 2f, paint)
        paint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)
        drawBitmap(this@toCircle, 0f, 0f, paint)
    }
}

fun Bitmap?.recycle() {
    if (this != null && !isRecycled) {
        recycle()
    }
}

/**
 * 压缩图片到文件
 *
 * @param toFile    文件
 * @param format  图片格式
 * @param quality 图片质量
 * @return 是否成功保存
 */
fun Bitmap.compress(
    toFile: File, @IntRange(from = 1, to = 100) quality: Int, format: Bitmap.CompressFormat): Boolean {
    return compress(format, quality, FileOutputStream(toFile))
}

/**
 * 根据蒙版叠加图片, 白色保留黑色过滤, 其他颜色自动根据色级调整透明度
 *
 * @param mask 蒙版图
 * @return 叠加后的图片
 */
fun Bitmap.masking(mask: Bitmap?): Bitmap {
    requireNotNull(mask) { "mask can not be null" }

    val w = width
    val h = height
    val maskW = mask.width
    val maskH = mask.height

    val useMask: Bitmap = if (w != maskW || h != maskH) {
        val m = mask.resize(w, h)
        mask.recycle()
        m
    } else {
        mask
    }

    val pix = IntArray(w * h)
    val maskPixArray = IntArray(w * h)
    getPixels(pix, 0, w, 0, 0, w, h)
    useMask.getPixels(maskPixArray, 0, w, 0, 0, w, h)

    var color: Int
    var red: Int
    var green: Int
    var blue: Int
    var maskColor: Int
    var maskAlpha: Int

    for (i in pix.indices) {
        color = pix[i]
        red = Color.red(color)
        green = Color.green(color)
        blue = Color.blue(color)

        maskColor = maskPixArray[i]
        maskAlpha = Color.red(maskColor) // 对比黑白, rgb都一样的值, 只需要获取其中一个的来当成比例计算就行了
        pix[i] = Color.argb(maskAlpha, red, green, blue)
    }

    mask.setPixels(pix, 0, w, 0, 0, w, h)
    return mask

}

/**
 * 模糊算法
 *
 * @param radius  模糊半径(1-25)
 * @param alloc 是否创建新的内存(为了减少内存占用的话就为false, 不想影响原图则为true)
 * @param context
 * @return 如果是mutable的图片, 返回的是原图
 */
fun Bitmap.blur(
    @IntRange(from = 1, to = 25) radius: Int = 20, context: Context = appContext, alloc: Boolean = false): Bitmap {
    var rs: RenderScript? = null

    val outputBitmap = if (alloc) Bitmap.createBitmap(this) else this
    try {
        rs = RenderScript.create(context)
        rs?.messageHandler = RenderScript.RSMessageHandler()
        val input = Allocation.createFromBitmap(
            rs, this, Allocation.MipmapControl.MIPMAP_NONE, Allocation.USAGE_SCRIPT)
        val output = Allocation.createTyped(rs, input.type)
        val blur = ScriptIntrinsicBlur.create(rs, Element.U8_4(rs))

        blur.setInput(input)
        blur.setRadius(radius.toFloat())
        blur.forEach(output)

        output.copyTo(outputBitmap)
    } finally {
        rs?.destroy()
    }

    return outputBitmap
}

fun Bitmap.newBlur(
    @FloatRange(from = 1.0, to = 25.0) radius: Float = 20f, context: Context = appContext): Bitmap {
    val bkg = small(this)
    val bitmap = bkg.copy(bkg.config, true)
    val rs = RenderScript.create(context)
    val input = Allocation.createFromBitmap(rs, bkg, Allocation.MipmapControl.MIPMAP_NONE,
        Allocation.USAGE_SCRIPT)
    val output = Allocation.createTyped(rs, input.type)
    val script = ScriptIntrinsicBlur.create(rs, Element.U8_4(rs))
    script.setRadius(radius)
    script.setInput(input)
    script.forEach(output)
    output.copyTo(bitmap)
    return big(bitmap)
}

fun big(bitmap: Bitmap): Bitmap {
    val matrix = Matrix()
    matrix.postScale(4f, 4f) //长和宽放大缩小的比例
    return Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
}

fun small(bitmap: Bitmap): Bitmap {
    val matrix = Matrix()
    matrix.postScale(0.25f, 0.25f) //长和宽放大缩小的比例
    return Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
}

/**
 * 将bitmap保存到文件中
 */
fun Bitmap.saveToFile(
    file: File, format: Bitmap.CompressFormat = Bitmap.CompressFormat.PNG, @IntRange(from = 0, to = 100) quality: Int = 100): Boolean {
    return file.outputStream().buffered().let {
        compress(format, quality, it)
    }
}

fun Bitmap.toHorizontalMirror(): Bitmap {
    val w = width
    val h = height
    val matrix = Matrix()
    matrix.postScale(-1f, 1f) // 水平镜像翻转
    return Bitmap.createBitmap(this, 0, 0, w, h, matrix, true)
}

/**
 * 剪切
 */
fun Bitmap.cropBitmap(rate: Float): Bitmap {
    val mStokeWidth = Screen.width.toFloat()
    val mStokeHeight = mStokeWidth / rate
    val mMinScaleX = mStokeWidth / width
    val mMinScaleY = mStokeHeight / height
    val mMinScale = Math.max(mMinScaleX, mMinScaleY)
    val left = (width * mMinScale - mStokeWidth) / 2
    val top = (height * mMinScale - mStokeHeight) / 2
    val mCropBitmap = Bitmap.createBitmap(mStokeWidth.toInt(), mStokeHeight.toInt(), Bitmap.Config.ARGB_8888)
    val canvas = Canvas(mCropBitmap)
    val paint = Paint(Paint.ANTI_ALIAS_FLAG)
    val bitmapShader = BitmapShader(this, Shader.TileMode.REPEAT, Shader.TileMode.REPEAT)
    val temp = Matrix()
    temp.postScale(mMinScale, mMinScale)
    temp.postTranslate(-left, -top)
    bitmapShader.setLocalMatrix(temp)
    paint.shader = bitmapShader
    canvas.drawRect(0f, 0f, mStokeWidth, mStokeHeight, paint)
    return mCropBitmap
}

/**
 * 剪切比例
 */
fun Bitmap.cropRate(): Float {
    var rate = 1f
    if (width.toFloat() / height.toFloat() <= 7f / 8f) {
        rate = 3f / 4f
    } else if (width.toFloat() / height.toFloat() > 7f / 6f) {
        rate = 4f / 3f
    }
    return rate
}

/**
 * 图片转base64
 */
fun Bitmap.toBase64(): String {
    var result = ""
    var baos: ByteArrayOutputStream? = null
    try {
        baos = ByteArrayOutputStream()
        this.compress(Bitmap.CompressFormat.JPEG, 100, baos)
        baos.flush()
        baos.close()
        val bitmapBytes: ByteArray = baos.toByteArray()
        result = Base64.encodeToString(bitmapBytes, Base64.DEFAULT)
    } catch (e: IOException) {
        e.printStackTrace()
    } finally {
        try {
            if (baos != null) {
                baos.flush()
                baos.close()
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }
    return result
}

