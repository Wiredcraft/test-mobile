package cn.hakim.animationapplication.view.sun

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.Path
import android.graphics.Point


import java.util.ArrayList

import cn.hakim.animationapplication.view.BaseActiveElement
import cn.hakim.animationapplication.view.Polygon

/**
 * 太阳
 */
internal class Sun(private val xxx: Int, private val mWidth: Int, private val mHeight: Int, context: Context, private val mColor: Int, private val PolygonWidth: Int) : BaseActiveElement {
    private var mPaint: Paint? = null
    private var xx = 1.0f
    private var cX: Float = 0.toFloat()
    private var cY = -100f
    private val points = ArrayList<Point>()
    var path: Path

    init {
        cX = (mWidth / 2).toFloat()
        cY = 200f
        path = Path()
        init()
    }

    fun init() {
        mPaint = Paint()
        mPaint!!.strokeWidth = 3f
        mPaint!!.color = mColor
        mPaint!!.isAntiAlias = true
        mPaint!!.style = Paint.Style.FILL

        val mp = Polygon(IntArray(9), IntArray(9), PolygonWidth)
        mp.posOfPoint(9)
        points.addAll(mp.points)

        for (i in points.indices) {
            if (i == 0)
                path.moveTo(points[0].x.toFloat(), points[0].y.toFloat())
            path.lineTo(points[i].x.toFloat(), points[i].y.toFloat())
        }
        path.lineTo(points[0].x.toFloat(), points[0].y.toFloat())
    }

    override fun move() {

    }


    override fun SetY(i: Float) {
        cY = i * 30
    }

    override fun SetX(i: Float) {
        cX = (xxx + i) * 30
    }

    override fun draw(canvas: Canvas) {

        canvas.save()
        canvas.translate(cX, cY)
        canvas.rotate(xx)

        xx += PolygonWidth.toFloat() / 1500
        if (xx >= 360.0f) xx = 0.0f

        canvas.drawPath(path, mPaint!!)
        canvas.restore()
    }
}