package com.fly.audio.util

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.media.ExifInterface
import android.text.TextUtils
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.IOException
import java.lang.reflect.Field
import kotlin.math.roundToInt

/**
 * Created by likainian on 2021/7/13
 * Description:  bitmap工具类
 */

object BitmapUtil {

    /**
     * 压缩后的图片，大小暂定400Kb，若觉得太大，可调整该值
     */
    const val IMAGE_COMPRESS_SIZE = 400


    private fun decodeFile(file: File, reqWidth: Int, reqHeight: Int): Bitmap {
        val options = BitmapFactory.Options()
        options.inJustDecodeBounds = true
        BitmapFactory.decodeFile(file.absolutePath, options)
        options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight)
        options.inJustDecodeBounds = false
        return BitmapFactory.decodeFile(file.absolutePath, options)
    }

    private fun calculateInSampleSize(options: BitmapFactory.Options, reqWidth: Int, reqHeight: Int): Int {
        val height = options.outHeight
        val width = options.outWidth
        var inSampleSize = 1
        if (height > reqHeight || width > reqWidth) {
            inSampleSize = if (width > height) {
                (height.toFloat() / reqHeight.toFloat()).roundToInt()
            } else {
                (width.toFloat() / reqWidth.toFloat()).roundToInt()
            }
            val totalPixels = (width * height).toFloat()
            val totalReqPixelsCap = (reqWidth * reqHeight * 2).toFloat()
            while (totalPixels / (inSampleSize * inSampleSize) > totalReqPixelsCap) {
                inSampleSize++
            }
        }
        return inSampleSize
    }

    private fun readPictureDegree(path: String): Int {
        var degree = 0
        try {
            val exifInterface = ExifInterface(path)
            when (exifInterface.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL)) {
                ExifInterface.ORIENTATION_ROTATE_90 -> degree = 90
                ExifInterface.ORIENTATION_ROTATE_180 -> degree = 180
                ExifInterface.ORIENTATION_ROTATE_270 -> degree = 270
            }
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return degree
    }

    private fun postRotateBitmap(bitmap: Bitmap, orientation: Float): Bitmap {
        return if (orientation > 0) {
            val matrix = Matrix()
            matrix.postRotate(orientation)
            Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
        } else {
            Bitmap.createScaledBitmap(bitmap, bitmap.width, bitmap.height, true)
        }
    }

    fun compressBitmap(bitmap: Bitmap): ByteArray {
        val outStream = ByteArrayOutputStream()
        var quality = 100
        bitmap.compress(Bitmap.CompressFormat.JPEG, quality, outStream)
        while (outStream.toByteArray().size / 1024 > IMAGE_COMPRESS_SIZE) {
            outStream.reset()
            quality -= 10
            bitmap.compress(Bitmap.CompressFormat.JPEG, quality, outStream)
        }
        return outStream.toByteArray()
    }

    /**
     * 将原图中包含的Location信息，写入压缩后的图片Exif信息中
     */
    fun saveExif(oldPath: String, newPath: String) {
        try {
            val oldExif = ExifInterface(oldPath)
            val newExif = ExifInterface(newPath)
            val cls = ExifInterface::class.java
            val fields: Array<Field> = cls.fields
            for (i in fields.indices) {
                val fieldName = fields[i].name
                if (!TextUtils.isEmpty(fieldName) && fieldName.startsWith("TAG_GPS")) {
                    fields[i].get(cls)?.let { obj ->
                        val fieldValue: String = obj.toString()
                        val attribute = oldExif.getAttribute(fieldValue)
                        if (attribute != null) {
                            newExif.setAttribute(fieldValue, attribute)
                        }
                    }
                }
            }
            newExif.saveAttributes()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

}