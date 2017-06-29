package cn.hakim.animationapplication.view


import android.graphics.Point

import java.util.ArrayList

/**
 * 正多边形
 */
class Polygon(private val x: IntArray//储存所有点x坐标
              , private val y: IntArray//储存所有点y坐标
              , private val r: Int//外接圆半径
) {
    private val startX: Int//开始x坐标
    private val startY: Int//开始y坐标
    val points = ArrayList<Point>()

    init {
        startX = 0
        startY = -r
    }

    fun posOfPoint(edges: Int) {
        x[0] = startX
        y[0] = startY
        var p: Point
        for (i in 0..edges - 1) {
            p = nextPoint(2 * Math.PI / edges * i)
            x[i] = p.x.toInt()
            y[i] = p.y.toInt()
            points.add(p)
        }
    }

    fun nextPoint(arc: Double): Point {
        val p = Point()
        p.set((x[0] - r * Math.sin(arc)).toInt(), (y[0] + r - r * Math.cos(arc)).toInt())
        return p
    }
}
