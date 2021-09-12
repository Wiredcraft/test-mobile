package com.andzhv.githubusers.widgets

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Rect
import android.util.AttributeSet
import android.view.View
import android.view.animation.DecelerateInterpolator
import android.widget.FrameLayout
import androidx.annotation.DimenRes
import androidx.core.view.NestedScrollingParent3
import androidx.core.view.NestedScrollingParentHelper
import androidx.core.view.ViewCompat
import androidx.core.view.updateLayoutParams
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.andzhv.githubusers.R
import kotlin.math.max
import kotlin.math.min

/**
 * Created by zhaowei on 2021/9/12.
 */
class SearchFrameLayout : FrameLayout, NestedScrollingParent3 {

    private lateinit var refreshLayout: SwipeRefreshLayout
    private lateinit var recyclerView: RecyclerView
    private lateinit var searchView: View
    private val parentHelper: NestedScrollingParentHelper = NestedScrollingParentHelper(this)
    private var isFling = false
    private var scrollAnimator: ValueAnimator? = null
    private var searchBarHeight = 0
        set(value) {
            if (field != value) {
                field = value
                for (i in 0 until recyclerView.itemDecorationCount) {
                    recyclerView.removeItemDecorationAt(0)
                }
                recyclerView.addItemDecoration(TopItemDecoration())
            }
        }

    constructor(context: Context) : super(context)
    constructor(context: Context, attributeSet: AttributeSet) : super(context, attributeSet)
    constructor(context: Context, attributeSet: AttributeSet, defStyle: Int) : super(
        context,
        attributeSet,
        defStyle
    )

    override fun onFinishInflate() {
        super.onFinishInflate()
        refreshLayout = findViewById(R.id.refreshLayout)
        recyclerView = findViewById(R.id.recyclerView)
        searchView = findViewById(R.id.searchView)
        searchBarHeight =
            getDimensionPx(R.dimen.search_bar_height) + getDimensionPx(R.dimen.search_bar_top_margin) * 2
        recyclerView.overScrollMode = OVER_SCROLL_NEVER
    }

    override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
        super.onSizeChanged(w, h, oldw, oldh)
        post {
            searchBarHeight = searchView.run {
                val lp = layoutParams as LayoutParams
                height + lp.topMargin + lp.bottomMargin
            }
            refreshLayout.updateLayoutParams<LayoutParams> {
                height = measuredHeight + searchBarHeight
            }
            refreshLayout.setProgressViewOffset(
                false,
                (searchView.layoutParams as LayoutParams).topMargin,
                searchBarHeight + refreshLayout.progressCircleDiameter / 2
            )
        }
    }

    override fun onStartNestedScroll(child: View, target: View, axes: Int, type: Int): Boolean {
        isFling = type == ViewCompat.TYPE_NON_TOUCH
        scrollAnimator?.cancel()
        return axes and ViewCompat.SCROLL_AXIS_VERTICAL != 0
    }


    override fun onNestedScrollAccepted(child: View, target: View, axes: Int, type: Int) {
        parentHelper.onNestedScrollAccepted(child, target, axes, type)
    }

    override fun onStopNestedScroll(target: View, type: Int) {
        parentHelper.onStopNestedScroll(target, type)
        //If isFling is true, wait for the end of filing
        if (isFling xor (type == ViewCompat.TYPE_TOUCH) && scrollY != 0 && scrollY != searchBarHeight) {
            startAnimation(scrollY < searchBarHeight / 2)
        }
    }

    override fun onNestedScroll(
        target: View,
        dxConsumed: Int,
        dyConsumed: Int,
        dxUnconsumed: Int,
        dyUnconsumed: Int,
        type: Int,
        consumed: IntArray
    ) {
    }

    override fun onNestedScroll(
        target: View,
        dxConsumed: Int,
        dyConsumed: Int,
        dxUnconsumed: Int,
        dyUnconsumed: Int,
        type: Int
    ) {
    }


    override fun onNestedPreScroll(target: View, dx: Int, dy: Int, consumed: IntArray, type: Int) {
        val offsetY = if (dy > 0) {
            min(dy, searchBarHeight - scrollY)
        } else {
            max(dy, -scrollY)
        }
        if (offsetY != 0) {
            scrollBy(0, offsetY)
            consumed[1] = offsetY
        }
    }

    private fun getDimensionPx(@DimenRes id: Int) = context.resources.getDimensionPixelSize(id)

    private fun startAnimation(isShow: Boolean) {
        if (scrollAnimator == null) {
            scrollAnimator = ValueAnimator().apply {
                addUpdateListener { animation ->
                    val animatedValue = animation.animatedValue as Int
                    scrollTo(0, animatedValue)
                }
            }
        } else {
            scrollAnimator?.cancel()
        }
        scrollAnimator?.interpolator = DecelerateInterpolator()
        scrollAnimator?.setIntValues(scrollY, if (isShow) 0 else searchBarHeight)
        val offsetY = if (isShow) scrollY else searchBarHeight - scrollY
        scrollAnimator?.duration = min(offsetY * 4, 300).toLong()
        scrollAnimator?.start()
    }

    inner class TopItemDecoration : RecyclerView.ItemDecoration() {
        override fun getItemOffsets(
            outRect: Rect,
            view: View,
            parent: RecyclerView,
            state: RecyclerView.State
        ) {
            super.getItemOffsets(outRect, view, parent, state)
            if (parent.getChildAdapterPosition(view) == 0) {
                outRect.top = searchBarHeight
            }
        }
    }

}