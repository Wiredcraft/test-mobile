package cn.hakim.animationapplication.view.sun

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.graphics.Point


import java.util.ArrayList

import cn.hakim.animationapplication.view.BaseActiveElement
import cn.hakim.animationapplication.view.Polygon

/**
 * 光环
 */
internal class Halo(xxx: Int, private val mWidth: Int, private val mHeight: Int, context: Context, private val mColor: Int) : BaseActiveElement {
    private var mPaint: Paint? = null
    private val points = ArrayList<Point>()
    private val paths = ArrayList<Path>()
    private var xx = 1.0f
    private var cX: Float = 0.toFloat()
    private var cY = -100f
    private val xxx: Float
    private var mAlpha: Float = 0.toFloat()
    private var fff: Float = 0.toFloat()

    init {
        cX = (mWidth / 2).toFloat()
        cY = (mHeight / 2).toFloat()
        this.xxx = xxx.toFloat()
        init()
    }

    fun init() {
        mPaint = Paint()
        mPaint!!.color = Color.WHITE
        paths.add(Path())
        paths.add(Path())
        paths.add(Path())
        paths.add(Path())
        val mp = Polygon(IntArray(6), IntArray(6), 100)
        mp.posOfPoint(6)
        points.addAll(mp.points)

        //初始化n个多边形的path
        for (p in paths.indices) {
            val mmp = Polygon(IntArray(6), IntArray(6), (p + 1) * 30)
            mmp.posOfPoint(6)
            mmp.points
            for (i in points.indices) {
                if (i == 0)
                    paths[p].moveTo(mmp.points[0].x.toFloat(), mmp.points[0].y.toFloat())
                paths[p].lineTo(mmp.points[i].x.toFloat(), mmp.points[i].y.toFloat())
            }
            paths[p].lineTo(mmp.points[0].x.toFloat(), mmp.points[0].y.toFloat())
        }
    }

    override fun move() {

    }

    override fun SetY(i: Float) {
        cY = mHeight / 2 + i * 10

    }

    override fun SetX(i: Float) {
        cX = mWidth / 2 + i * 10
        fff = 0 - i * 8
    }

    fun Alpha(f: Float) {
        if (f < 0.0f) return
        mAlpha = f * 25
    }

    override fun draw(canvas: Canvas) {
        for (i in paths.indices) {
            canvas.save()
            canvas.translate(cX + i * fff, cY + i * 200)
            canvas.rotate(xx)
            xx += 0.07f
            if (xx >= 360.0f) xx = 0.0f
            mPaint!!.alpha = mAlpha.toInt()
            canvas.drawPath(paths[i], mPaint!!)
            canvas.restore()
        }
    }
}
