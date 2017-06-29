package cn.hakim.animationapplication.view.drawable

import android.graphics.Canvas
import android.graphics.Paint

import java.util.Random

/**
 * Created by Administrator on 2017/6/26.
 */

class RainItem {
    private var width: Int = 0
    private var height: Int = 0

    private var startX: Float = 0.toFloat()//开始位置
    private var startY: Float = 0.toFloat()

    private var stopX: Float = 0.toFloat()//结束位置
    private var stopY: Float = 0.toFloat()
    private var sizeX: Float = 0.toFloat()
    private var sizeY: Float = 0.toFloat()
    private var paint: Paint? = null
    private var random: Random? = null

    private var size = 20
    private var color: Int = 0
    // 随机 雨点颜色
    private var randColor = false

    constructor(width: Int, height: Int) {
        this.width = width
        this.height = height
        init()
    }

    constructor(width: Int, height: Int, size: Int) {
        this.size = size
        this.width = width
        this.height = height
        init()
    }

    constructor(width: Int, height: Int, size: Int, color: Int) {
        this.color = color
        this.size = size
        this.width = width
        this.height = height
        init()
    }

    constructor(width: Int, height: Int, size: Int, color: Int,
                randColor: Boolean) {
        this.randColor = randColor
        this.color = color
        this.size = size
        this.width = width
        this.height = height
        init()
    }

    private val rainWidth = 10f
    private fun init() {
        random = Random()
        val sizeN = random!!.nextInt(size)
        sizeX = (sizeN * deltaX / length).toFloat()
        sizeY = (sizeN * deltaY / length).toFloat()
        startX = random!!.nextInt(width).toFloat()
        startY = random!!.nextInt(height).toFloat()
        stopX = startX + sizeX
        stopY = startY + sizeY
        paint = Paint()
        paint!!.strokeWidth = rainWidth
        if (randColor) {
            // 颜色随机值。
            val r = random!!.nextInt(256)
            val g = random!!.nextInt(256)
            val b = random!!.nextInt(256)

            paint!!.setARGB(255, r, g, b)
        } else {
            paint!!.color = color
        }
    }

    fun draw(canvas: Canvas) {
        canvas.drawLine(startX, startY, stopX, stopY, paint!!)
    }

    private val speed = 50
    private val deltaX = -20.0//负数往左
    private var deltaY = -30.0//负数往上
    private var length = Math.sqrt(deltaX * deltaX + deltaY * deltaY)

    fun move() {
        startX += (speed * deltaX / length).toFloat()
        stopX += (speed * deltaX / length).toFloat()

        startY += (speed * deltaY / length).toFloat()
        stopY += (speed * deltaY / length).toFloat()

        if (startY > height || startY < 0 || startX < 0 || startX > width) {
            init()
        }
    }

    fun setXY(x: Double, y: Double) {
        this.deltaY = x
        this.deltaY = y
        length = Math.sqrt(deltaX * deltaX + deltaY * deltaY)
    }

}
