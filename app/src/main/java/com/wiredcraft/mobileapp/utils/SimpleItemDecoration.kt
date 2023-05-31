package com.wiredcraft.mobileapp.utils

import android.content.Context
import android.content.res.Resources
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Rect
import android.util.TypedValue
import android.view.View
import android.widget.LinearLayout
import androidx.annotation.ColorRes
import androidx.annotation.IntDef
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.*
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy

/**
 * @date 2023/5/30
 * @author lhq
 * @desc:
 * 默认竖直排列RecyclerView分割线
 *
 * 使用
 * SimpleItemDecoration simpleItemDecoration = SimpleItemDecoration.getInstance(context);
 * 1.设置排列方向[setOrientation]，不设置默认为竖直排列
 * 2.（可选）设置分割线颜色[setDividerColor]，不设置默认为#E5E5E5
 * 3.（可选）设置分割线两端的padding[setPaddingOrientation],默认顶RecyclerView
 * 4.（可选）设置分割线大小，单位为dp[setDividerSize]，不设置默认为2px
 * recyclerView.addItemDecoration(simpleItemDecoration);
 *
 */
class SimpleItemDecoration private constructor(private val context: Context) : ItemDecoration() {
    private var dividerSize = 2F //分割线的高度为2px
    private val dividerPaint: Paint = Paint() //分割线画笔
    private var paddingOrientation = 0F

    private var isShowLast = true

    val HORIZONTAL = LinearLayout.HORIZONTAL
    val VERTICAL = LinearLayout.VERTICAL
    private var mOrientation = VERTICAL

    init {
        dividerPaint.color = Color.parseColor("#E5E5E5")
    }

    //实现padding的效果
    override fun getItemOffsets(
        outRect: Rect,
        view: View,
        parent: RecyclerView,
        state: RecyclerView.State
    ) {
        super.getItemOffsets(outRect, view, parent, state)

        val position = parent.getChildAdapterPosition(view)
        val lastIndex = parent.adapter!!.itemCount - 1
        if (position == lastIndex){
            if (isShowLast){
                if (mOrientation == VERTICAL) {
                    outRect.bottom = dividerSize.toInt()
                } else if (mOrientation == HORIZONTAL) {
                    outRect.right = dividerSize.toInt()
                }
            } else {
                if (mOrientation == VERTICAL) {
                    outRect.bottom = 0
                } else if (mOrientation == HORIZONTAL) {
                    outRect.right = 0
                }
            }
        } else {
            if (mOrientation == VERTICAL) {
                outRect.bottom = dividerSize.toInt()
            } else if (mOrientation == HORIZONTAL) {
                outRect.right = dividerSize.toInt()
            }
        }
    }

    //实现绘制背景的效果,填充padding等部分
    override fun onDraw(c: Canvas, parent: RecyclerView, state: RecyclerView.State) {
        if (mOrientation == VERTICAL) {
            drawVertical(c, parent)
        } else {
            drawHorizontal(c, parent)
        }
    }

    //绘制在item内容上面，覆盖内容
    override fun onDrawOver(c: Canvas, parent: RecyclerView, state: RecyclerView.State) {

    }

    private fun drawHorizontal(canvas: Canvas, parent: RecyclerView) {
        val count = parent.childCount
        val dif = if (isShowLast) 1 else 2
        for (i in 0 until count - dif) {
            val child = parent.getChildAt(i)
            canvas.drawRect(
                child.right.toFloat(),
                (child.top + paddingOrientation).toFloat(),
                (child.right + dividerSize).toFloat(),
                (child.bottom - paddingOrientation).toFloat(),
                dividerPaint
            )
        }
    }

    private fun drawVertical(canvas: Canvas, parent: RecyclerView) {
        val count = parent.childCount
        val dif = if (isShowLast) 1 else 2
        for (i in 0 until count - dif) {
            val child = parent.getChildAt(i)
            val top = child.bottom.toFloat()
            val bottom = child.bottom + dividerSize
            canvas.drawRect(
                paddingOrientation,
                top,
                (parent.width - paddingOrientation),
                bottom,
                dividerPaint
            )
        }
    }

    /**
     * 设置空白边距
     * @param paddingLeft 单位dp
     */
    fun setPaddingOrientation(paddingLeft: Float): SimpleItemDecoration {
        this.paddingOrientation = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, paddingLeft, context.resources.displayMetrics)
        return this
    }

    /**
     * 设置方向
     */
    fun setOrientation(@OrientationMode orientation: Int): SimpleItemDecoration {
        this.mOrientation = orientation
        return this
    }

    /**
     * 设置分割线的高度
     * @param dividerHeight  单位dp
     */
    fun setDividerSize(dividerHeight: Float): SimpleItemDecoration {
        this.dividerSize = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, dividerHeight, context.resources.displayMetrics)
        return this
    }

    /**
     * 设置分割线的颜色
     * @param colorId 颜色
     * @return
     */
    fun setDividerColor(@ColorRes colorId: Int): SimpleItemDecoration {
        dividerPaint.color = context.resources.getColor(colorId)
        return this
    }

    /**
     * 设置是否显示最后一条
     */
    fun setShowLast(show: Boolean): SimpleItemDecoration{
        isShowLast = show
        return this
    }

    companion object {
        /**
         * 创建对象
         * @param context 上下文
         * @return
         */
        fun getInstance(context: Context): SimpleItemDecoration {
            return SimpleItemDecoration(context)
        }
    }

    init {
        dividerPaint.color = Color.parseColor("#f0f0f0") //默认的分割线颜色
    }


    @IntDef(HORIZONTAL, VERTICAL)
    @Retention(RetentionPolicy.SOURCE)
    annotation class OrientationMode
}