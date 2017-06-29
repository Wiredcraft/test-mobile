package cn.hakim.animationapplication.view.sun

import android.content.Context
import android.graphics.Canvas
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.util.AttributeSet

import java.util.ArrayList

import cn.hakim.animationapplication.R
import cn.hakim.animationapplication.view.WeatherView

/**
 * Created by Administrator on 2017/6/28.
 */

class SunView : WeatherView {
    private val mColors = intArrayOf(resources.getColor(R.color.colorSun), resources.getColor(R.color.colorSunn), resources.getColor(R.color.colorSunnn), resources.getColor(R.color.colorSunnnn), resources.getColor(R.color.colorSunnnnn), resources.getColor(R.color.colorSunnnnnn), resources.getColor(R.color.colorSunnnnnnn), resources.getColor(R.color.colorSunnnnnnnn))
    private var mSunbg: SunBg? = null
    private var mHalo: Halo? = null
    private var mContext: Context? = null
    private var mSunBeams: ArrayList<Sun>? = ArrayList()


    constructor(context: Context) : super(context) {}

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {}

    protected override val sensorType: Int
        get() = Sensor.TYPE_GRAVITY

    override fun drawSub(canvas: Canvas) {
        mSunbg!!.draw(canvas)
        for (i in mSunBeams!!.indices) {
            mSunBeams!![i].draw(canvas)
        }
        mHalo!!.draw(canvas)
    }

    override fun logic() {

    }

    override fun init() {
        mContext = context
        mSunbg = SunBg(width, height, mContext!!, resources.getColor(R.color.colorSunBg))
        mHalo = Halo(20, width, height, mContext!!, resources.getColor(R.color.colorCloudBackgroundDay))
        for (i in mColors.indices.reversed()) {
            try {
                val sunBeam = Sun(20, width, height, mContext!!, mColors[i], i * 150)
                mSunBeams!!.add(sunBeam)
            } catch (e: Exception) {
                e.printStackTrace()
            }

        }
    }

    override fun onSensorChanged(event: SensorEvent) {
        for (i in mSunBeams!!.indices) {
            mSunBeams!![i].SetY(event.values[1])
            mSunBeams!![i].SetX(event.values[0])

            mHalo!!.SetY(event.values[1])
            mHalo!!.SetX(event.values[0])
            mHalo!!.Alpha(event.values[2])
        }
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {

    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        mSunBeams!!.clear()
        mSunBeams = null
    }

    override val defaultWidth: Int
        get() = 400

    override val defaultHeight: Int
        get() = 400
}
