package com.wiredcraft.decoration

import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.RecyclerView

class VerticalDecoration : RecyclerView.ItemDecoration() {
    private val dividerHeight = 1
    private val paint = Paint().apply {
        isAntiAlias = true
        color = Color.parseColor("#FFEFEFEF")
    }

    override fun getItemOffsets(
        outRect: Rect,
        view: View,
        parent: RecyclerView,
        state: RecyclerView.State
    ) {
        if (parent.getChildAdapterPosition(view) == 0) {
            outRect.top = 0
        } else {
            outRect.top = dividerHeight
        }
    }

    override fun onDraw(c: Canvas, parent: RecyclerView, state: RecyclerView.State) {
        for (i in 0 until parent.childCount) {
            val view = parent.getChildAt(i)
            if (parent.getChildAdapterPosition(view) != 0) {
                c.drawRect(
                    view.paddingLeft.toFloat(),
                    view.top.toFloat(),
                    (view.right - view.paddingRight).toFloat(),
                    view.top.toFloat() + dividerHeight,
                    paint
                )
            }
        }
    }
}