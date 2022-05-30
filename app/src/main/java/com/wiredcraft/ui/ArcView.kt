package com.wiredcraft.ui

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.Path
import android.util.AttributeSet
import android.view.View
import com.wiredcraft.R

class ArcView(context: Context, attributeSet: AttributeSet) : View(context, attributeSet) {

    private val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = context.getColor(R.color.black_1A)
    }
    private val path = Path()

    override fun onDraw(canvas: Canvas) {
        path.moveTo(0f, 0f)
        path.quadTo(width / 2f, height * 1.3f, width.toFloat(), 0f)
        canvas.drawPath(path, paint)
    }
}