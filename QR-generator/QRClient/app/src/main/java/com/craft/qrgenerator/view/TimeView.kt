package com.craft.qrgenerator.view

import android.content.Context
import android.os.Build
import android.os.CountDownTimer
import android.support.annotation.RequiresApi
import android.util.AttributeSet
import android.widget.TextView
import com.craft.qrgenerator.utils.AppUtils


class TimeView : TextView {

    companion object {
        const val INTERVAL = 1000L
    }

    var mTimer: CountDownTimer? = null
    var mListener: TimerListener? = null

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int, defStyleRes: Int) :
            super(context, attrs, defStyleAttr, defStyleRes)

    /**
     * start count down
     */
    fun start(expireTime: Long, l: TimerListener?) {
        mListener = l
        //get count down time
        val time = expireTime - System.currentTimeMillis()
        text = AppUtils.showTime(time)
        if (time <= 0) {
            return
        }

        mTimer = object : CountDownTimer(time, INTERVAL) {

            override fun onTick(millisUntilFinished: Long) {
                //update time
                text = AppUtils.showTime(millisUntilFinished)
            }

            override fun onFinish() {
                mListener?.onFinish()
            }
        }
        mTimer?.start()
    }

    /**
     * stop count down
     */
    fun stop() {
        mTimer?.cancel()
    }

    interface TimerListener {
        fun onFinish()
    }


}