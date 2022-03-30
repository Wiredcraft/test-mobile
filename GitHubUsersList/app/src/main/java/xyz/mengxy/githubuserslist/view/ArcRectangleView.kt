package xyz.mengxy.githubuserslist.view

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.View
import xyz.mengxy.githubuserslist.R

/**
 * Created by Mengxy on 3/30/22.
 */
class ArcRectangleView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {

    private var arcHeight = 0
    private var bgColor = Color.BLACK
    private var viewWidth = 0
    private var viewHeight = 0

    private val rect = Rect(0, 0, 0, 0)
    private val arcPaint = Paint(Paint.ANTI_ALIAS_FLAG)
    private val arcPath = Path()

    init {
        context.obtainStyledAttributes(attrs, R.styleable.ArcRectangleView).apply {
            arcHeight = getDimensionPixelSize(R.styleable.ArcRectangleView_arcHeight, 0)
            bgColor = getColor(R.styleable.ArcRectangleView_backgroundColor, Color.BLACK)
        }.recycle()
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
        if (MeasureSpec.getMode(widthMeasureSpec) == MeasureSpec.EXACTLY) {
            viewWidth = MeasureSpec.getSize(widthMeasureSpec)
        }
        if (MeasureSpec.getMode(heightMeasureSpec) == MeasureSpec.EXACTLY) {
            viewHeight = MeasureSpec.getSize(heightMeasureSpec)
        }
        setMeasuredDimension(viewWidth, viewHeight)
    }

    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        arcPaint.apply {
            style = Paint.Style.FILL
            color = bgColor
        }
        canvas?.drawRect(rect.apply {
            set(0, 0, viewWidth, viewHeight - arcHeight)
        }, arcPaint)

        arcPath.apply {
            moveTo(0f, (viewHeight - arcHeight).toFloat())
            quadTo(
                (viewWidth shr 1).toFloat(), viewHeight.toFloat(), viewWidth.toFloat(),
                (viewHeight - arcHeight).toFloat()
            )
        }
        canvas?.drawPath(arcPath, arcPaint)
    }
}