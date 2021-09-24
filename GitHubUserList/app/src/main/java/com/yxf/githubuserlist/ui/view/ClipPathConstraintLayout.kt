package com.yxf.githubuserlist.ui.view

import android.content.Context
import android.graphics.Canvas
import android.graphics.PointF
import android.util.AttributeSet
import android.view.View
import androidx.constraintlayout.widget.ConstraintLayout
import com.yxf.clippathlayout.ClipPathLayout
import com.yxf.clippathlayout.ClipPathLayoutDelegate
import com.yxf.clippathlayout.PathInfo

class ClipPathConstraintLayout : ConstraintLayout, ClipPathLayout {


    private val delegate = ClipPathLayoutDelegate(this)


    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    )

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int, defStyleRes: Int) : super(
        context,
        attrs,
        defStyleAttr,
        defStyleRes
    )

    override fun isTransformedTouchPointInView(
        x: Float,
        y: Float,
        child: View?,
        outLocalPoint: PointF?
    ): Boolean {
        return delegate.isTransformedTouchPointInView(x, y, child, outLocalPoint)
    }

    override fun applyPathInfo(info: PathInfo?) {
        delegate.applyPathInfo(info)
    }

    override fun cancelPathInfo(child: View?) {
        delegate.cancelPathInfo(child)
    }

    override fun beforeDrawChild(canvas: Canvas?, child: View?, drawingTime: Long) {
        delegate.beforeDrawChild(canvas, child, drawingTime)
    }

    override fun drawChild(canvas: Canvas?, child: View?, drawingTime: Long): Boolean {
        beforeDrawChild(canvas, child, drawingTime)
        val result = super.drawChild(canvas, child, drawingTime)
        afterDrawChild(canvas, child, drawingTime)
        return result
    }

    override fun afterDrawChild(canvas: Canvas?, child: View?, drawingTime: Long) {
        delegate.afterDrawChild(canvas, child, drawingTime)
    }

    override fun notifyPathChanged(child: View?) {
        delegate.notifyPathChanged(child)
    }

    override fun notifyAllPathChanged() {
        delegate.notifyAllPathChanged()
    }

    override fun requestLayout() {
        super.requestLayout()
        // the request layout method would be invoked in the constructor of super class
        if (delegate == null) {
            return
        }
        delegate.requestLayout()
    }

}