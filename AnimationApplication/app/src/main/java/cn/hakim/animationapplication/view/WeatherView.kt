package cn.hakim.animationapplication.view

import android.content.ContentResolver
import android.content.Context
import android.graphics.Canvas
import android.hardware.Sensor
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.util.AttributeSet
import android.view.View

/**
 * Created by Administrator on 2017/6/28.
 */

abstract class WeatherView : View, SensorEventListener {
    constructor(context: Context) : super(context) {
        initView(context, null, -1)
    }

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
        initView(context, attrs, -1)
    }

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        initView(context, attrs, defStyleAttr)
    }

    private var sm: SensorManager? = null
    private var sensor: Sensor? = null
    private fun initView(context: Context, attrs: AttributeSet?, defStyleAttr: Int) {
        sm = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        sensor = sm!!.getDefaultSensor(sensorType)
        sm!!.registerListener(this, sensor, SensorManager.SENSOR_DELAY_FASTEST)
    }

    protected abstract val sensorType: Int

    protected abstract fun drawSub(canvas: Canvas)

    protected abstract fun logic()

    protected abstract fun init()
    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        sm!!.registerListener(this, sensor, SensorManager.SENSOR_DELAY_FASTEST)
    }

    private var running = true
    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        running = false
        sm!!.unregisterListener(this)
        System.gc()
    }

    internal inner class DrawThread : Thread() {
        override fun run() {
            init()
            while (running) {
                logic()
                postInvalidate()
                try {
                    Thread.sleep(20)
                } catch (e: InterruptedException) {
                    e.printStackTrace()
                }

            }
        }
    }

    private var thread: DrawThread? = null
    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        if (thread == null) {
            thread = DrawThread()
            thread!!.start()
        } else {
            drawSub(canvas)
        }
    }

    abstract val defaultWidth: Int
    abstract val defaultHeight: Int
    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {

        val widthMode = View.MeasureSpec.getMode(widthMeasureSpec)
        val widthSize = View.MeasureSpec.getSize(widthMeasureSpec)
        val heightMode = View.MeasureSpec.getMode(heightMeasureSpec)
        val heightSize = View.MeasureSpec.getSize(heightMeasureSpec)

        val width: Int
        val height: Int

        //Measure Width
        if (widthMode == View.MeasureSpec.EXACTLY) {
            //matchParent,给定值方式
            width = widthSize
        } else if (widthMode == View.MeasureSpec.AT_MOST) {
            //wrap_content方式
            width = Math.min(defaultWidth, widthSize)
        } else {
            width = defaultWidth
        }

        //Measure Height
        if (heightMode == View.MeasureSpec.EXACTLY) {
            //matchParent,给定值方式
            height = heightSize
        } else if (heightMode == View.MeasureSpec.AT_MOST) {
            //wrap_content方式
            height = Math.min(defaultHeight, heightSize)
        } else {
            height = defaultHeight
        }

        setMeasuredDimension(width, height)
    }
}
