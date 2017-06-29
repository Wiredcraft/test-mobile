package cn.hakim.animationapplication.view.sun

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint

import cn.hakim.animationapplication.view.BaseActiveElement

/**
 * 天空
 */
internal class SunBg(private val mWidth: Int, private val mHeight: Int, context: Context, private val mColor: Int) : BaseActiveElement {
    private var mPaint: Paint? = null

    init {
        init()
    }

    fun init() {
        mPaint = Paint()
        mPaint!!.color = mColor
    }

    override fun move() {

    }

    override fun draw(canvas: Canvas) {
        canvas.drawRect(0f, 0f, mWidth.toFloat(), mHeight.toFloat(), mPaint!!)
    }

    override fun SetX(i: Float) {

    }

    override fun SetY(i: Float) {

    }
}
