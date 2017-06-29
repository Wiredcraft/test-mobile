package cn.hakim.animationapplication.view.drawable

import android.animation.Animator
import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.ColorFilter
import android.graphics.Matrix
import android.graphics.PixelFormat
import android.graphics.drawable.Drawable
import android.os.Handler
import android.support.annotation.IntRange
import android.view.View
import android.view.animation.Animation
import android.view.animation.Interpolator
import android.view.animation.Transformation

import java.util.ArrayList

import cn.hakim.animationapplication.view.PtrLocalDisplay

/**
 * Created by Administrator on 2017/6/26.
 */

class PhysicsDrawable(private val mContext: Context, private val mParent: View) : Drawable() {
    private val mMatrix: Matrix

    init {
        mMatrix = Matrix()
        initiateDimens()
    }

    private var mScreenWidth: Int = 0
    private var mScreenHeight: Int = 0
    private fun initiateDimens() {
        PtrLocalDisplay.init(mContext)
        mScreenWidth = mContext.resources.displayMetrics.widthPixels
        mScreenHeight = mContext.resources.displayMetrics.heightPixels
    }

    private val list = ArrayList<RainItem>()
    private val rainNum = 1
    private val size = 500
    private val rainColor = Color.BLUE

    private var thread: MoveThread? = null
    override fun draw(canvas: Canvas) {
        if (thread == null) {
            thread = MoveThread()
            thread!!.start()
        } else {
            drawRain(canvas)
        }
    }

    override fun setAlpha(@IntRange(from = 0, to = 255) i: Int) {

    }

    override fun setColorFilter(colorFilter: ColorFilter?) {

    }

    override fun getOpacity(): Int {
        return PixelFormat.TRANSLUCENT
    }


    fun startRain() {
        this.running = true
    }

    fun stopRain() {
        this.running = false
        thread = null
    }

    private fun initRain() {
        list.clear()
        for (i in 0..rainNum - 1) {
            val item = RainItem(mScreenWidth, mScreenHeight, size,
                    rainColor, true)
            list.add(item)
        }
    }

    private fun drawRain(canvas: Canvas) {
        for (item in list) {
            item.draw(canvas)
        }
    }

    private fun moveRain() {
        for (item in list) {
            item.move()
        }
    }

    private var running = true

    internal inner class MoveThread : Thread() {
        override fun run() {
            initRain()
            while (running) {
                moveRain()
                mHandler.post { invalidateSelf() }
                try {
                    Thread.sleep(30)
                } catch (e: InterruptedException) {
                    e.printStackTrace()
                }

            }
        }
    }

    internal var mHandler = Handler()

    fun setXY(x: Double, y: Double) {
        for (item in list) {
            item.setXY(x, y)
        }
    }
}
