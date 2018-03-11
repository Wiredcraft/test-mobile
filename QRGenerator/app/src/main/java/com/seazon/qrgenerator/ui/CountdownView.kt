package com.seazon.qrgenerator.ui

import android.content.Context
import android.os.CountDownTimer
import android.util.AttributeSet
import android.widget.TextView
import com.seazon.qrgenerator.utils.CommonUtils

/**
 * Created by seazon on 2018/3/11.
 */
class CountdownView : TextView {

    val INTERVAL = 1000L

    var cdt: CountDownTimer? = null
    var listener: TicListener? = null

    constructor(context: Context) : super(context)

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int, defStyleRes: Int) : super(context, attrs, defStyleAttr, defStyleRes)

    fun start(expireTime: Long, l: TicListener) {
        listener = l
        val leftTime = expireTime - System.currentTimeMillis()
        text = CommonUtils.showCountdown(leftTime)
        if (leftTime <= 0) {
            return
        }

        cdt = object : CountDownTimer(leftTime, INTERVAL) {

            override fun onTick(millisUntilFinished: Long) {
                text = CommonUtils.showCountdown(millisUntilFinished)
            }

            override fun onFinish() {
                listener?.onFinish()
            }
        }
        cdt?.start()
    }

    fun stop() {
        cdt?.cancel()
    }

    interface TicListener {
        fun onFinish()
    }

}