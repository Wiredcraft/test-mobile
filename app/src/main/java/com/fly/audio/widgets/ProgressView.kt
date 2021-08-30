package com.fly.audio.widgets

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.View
import com.fly.audio.R
import com.fly.core.util.Res

/**
 * Created by likainian on 2021/7/13
 * Description:  进度条
 */

class ProgressView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {

    private var colors: IntArray
    private val maxCount = 100f
    private var progress = 0
    private var mBackPaint: Paint = Paint()
    private var mPaint: Paint = Paint()
    private var strokeWidth: Float = 10f
    private val rectBlackBg = RectF()

    init {
        mBackPaint.isAntiAlias = true
        mBackPaint.strokeWidth = strokeWidth
        mBackPaint.style = Paint.Style.STROKE
        mBackPaint.color = Res.getColor(R.color.color_E6EEFA)
        mPaint.isAntiAlias = true
        mPaint.strokeWidth = strokeWidth
        mPaint.style = Paint.Style.STROKE
        mPaint.strokeCap = Paint.Cap.ROUND
        colors = intArrayOf(
            Res.getColor(R.color.color_0468FF),
            Res.getColor(R.color.color_00AEFF)
        )
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        rectBlackBg.set(strokeWidth, strokeWidth, width - strokeWidth, height - strokeWidth)
        canvas.drawArc(rectBlackBg, 0f, 360f, false, mBackPaint)
        val section = progress / maxCount
        mPaint.shader = getLinearGradient(section)
        canvas.drawArc(rectBlackBg, 0f, section * 360, false, mPaint)

    }

    private fun getLinearGradient(section: Float): LinearGradient {
        return LinearGradient(
            0f, 0f, width * section, height.toFloat(),
            colors, null, Shader.TileMode.MIRROR
        )
    }

    fun setProgress(progress: Int) {
        this.progress = if (progress > maxCount) maxCount.toInt() else progress
        invalidate()
    }
}