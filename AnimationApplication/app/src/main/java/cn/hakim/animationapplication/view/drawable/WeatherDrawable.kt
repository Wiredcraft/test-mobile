package cn.hakim.animationapplication.view.drawable

import android.content.Context
import android.graphics.Canvas
import android.graphics.ColorFilter
import android.graphics.PixelFormat
import android.graphics.drawable.Drawable
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.support.annotation.IntRange

/**
 * Created by Administrator on 2017/6/28.
 */

abstract class WeatherDrawable(private val mContext: Context) : Drawable(), SensorEventListener {

    override fun draw(canvas: Canvas) {

    }

    override fun setAlpha(@IntRange(from = 0, to = 255) alpha: Int) {

    }

    override fun setColorFilter(colorFilter: ColorFilter?) {

    }

    override fun getOpacity(): Int {
        return PixelFormat.TRANSLUCENT
    }

    protected abstract val sensorType: Int
}
