package com.wiredcraft.mobileapp.widget

import android.content.Context
import android.util.AttributeSet
import android.util.TypedValue
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import com.wiredcraft.mobileapp.R

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: simple view state, including Loading、Error、Empty
 *
 */
class StateView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null
) : FrameLayout(context, attrs) {

    private var emptyViewContainer: LinearLayout
    private var tvEmptyText: TextView?=null
    private var ivEmptyIcon: ImageView
    var tvEmptyBtn: TextView

    private var errorViewContainer: LinearLayout
    private var tvErrorText: TextView
    private var ivErrorIcon: ImageView
    var tvErrorBtn: TextView

    private var loadingViewContainer: LinearLayout
    private var tvLoadingText: TextView
    private var ivLoadingIcon: ImageView

    var state = State.EMPTY
        set(value) {
            field = value
            when (value) {
                State.LOADING -> {
                    emptyViewContainer.visibility = View.GONE
                    loadingViewContainer.visibility = View.VISIBLE
                    errorViewContainer.visibility = View.GONE
                }
                State.EMPTY -> {
                    emptyViewContainer.visibility = View.VISIBLE
                    loadingViewContainer.visibility = View.GONE
                    errorViewContainer.visibility = View.GONE
                }
                State.ERROR -> {
                    emptyViewContainer.visibility = View.GONE
                    loadingViewContainer.visibility = View.GONE
                    errorViewContainer.visibility = View.VISIBLE
                }
            }
        }

    init {
        LayoutInflater.from(context).run {
            inflate(R.layout.view_empty, this@StateView)
            inflate(R.layout.view_error, this@StateView)
            inflate(R.layout.view_loading, this@StateView)
        }
        emptyViewContainer = findViewById(R.id.ll_empty_container)
        errorViewContainer = findViewById(R.id.ll_error_container)
        loadingViewContainer = findViewById(R.id.ll_loading_container)

        loadingViewContainer.visibility = View.GONE
        emptyViewContainer.visibility = View.VISIBLE
        errorViewContainer.visibility = View.GONE

        tvEmptyText = findViewById(R.id.tv_empty_text)
        ivEmptyIcon = findViewById(R.id.iv_empty_icon)
        tvEmptyBtn = findViewById(R.id.tv_empty_btn)
        tvEmptyBtn.setOnClickListener {
            onEmptyBtnClickListener?.onEmptyBtnClick()
        }

        tvErrorText = findViewById(R.id.tv_error_text)
        ivErrorIcon = findViewById(R.id.iv_error_icon)
        tvErrorBtn = findViewById(R.id.tv_error_btn)
        tvErrorBtn.setOnClickListener {
            onErrorBtnClickListener?.onErrorBtnClick()
        }

        tvLoadingText = findViewById(R.id.tv_loading_text)
        ivLoadingIcon = findViewById(R.id.iv_loading_icon)

        emptyViewContainer.setOnClickListener {
            onStateClickListener?.stateClick(state)
        }

        errorViewContainer.setOnClickListener {
            onStateClickListener?.stateClick(state)
        }
    }

    fun setEmptyImage(@DrawableRes resId: Int){
        ivEmptyIcon.setImageResource(resId)
    }

    fun setEmptyImageSize(height:Int,width:Int){
        ivEmptyIcon.layoutParams.height = height
        ivEmptyIcon.layoutParams.width = width
    }

    fun setEmptyText(text: String){
        tvEmptyText!!.text = text
    }

    fun setEmptyTextColor(color: Int){
        tvEmptyText!!.setTextColor(color)
    }

    fun setEmptyTextSize(size: Float){
        tvEmptyText!!.setTextSize(TypedValue.COMPLEX_UNIT_SP,size)
    }

    fun setEmptyText(@StringRes text: Int){
        tvEmptyText!!.text = resources.getString(text)
    }

    fun setEmptyBtnText(text: String){
        tvEmptyBtn.visibility = View.VISIBLE
        tvEmptyBtn.text = text
    }

    fun setEmptyBtnText(@StringRes text: Int){
        tvEmptyBtn.visibility = View.VISIBLE
        tvEmptyBtn.text = resources.getString(text)
    }



    fun setErrorImage(@DrawableRes resId: Int){
        ivErrorIcon.setImageResource(resId)
    }

    fun setErrorText(text: String){
        tvErrorText.text = text
    }

    fun setErrorText(@StringRes text: Int){
        tvErrorText.text = resources.getString(text)
    }

    fun setErrorBtnText(text: String){
        tvErrorBtn.visibility = View.VISIBLE
        tvErrorBtn.text = text
    }

    fun setErrorBtnText(@StringRes text: Int){
        tvErrorBtn.visibility = View.VISIBLE
        tvErrorBtn.text = resources.getString(text)
    }



    fun setCustomEmptyView(view: View) {
        emptyViewContainer.removeAllViews()
        emptyViewContainer.addView(view)
    }

    fun setCustomErrorView(view: View) {
        errorViewContainer.removeAllViews()
        errorViewContainer.addView(view)
    }

    fun setCustomLoadingView(view: View) {
        loadingViewContainer.removeAllViews()
        loadingViewContainer.addView(view)
    }

    enum class State {
        LOADING,
        EMPTY,
        ERROR
    }

    var onStateClickListener: OnStateClickListener? = null
    interface OnStateClickListener {
        fun stateClick(state: State)
    }

    var onEmptyBtnClickListener: OnEmptyBtnClickListener? = null
    interface OnEmptyBtnClickListener{
        fun onEmptyBtnClick()
    }
    var onErrorBtnClickListener: OnErrorBtnClickListener? = null
    interface OnErrorBtnClickListener{
        fun onErrorBtnClick()
    }
}