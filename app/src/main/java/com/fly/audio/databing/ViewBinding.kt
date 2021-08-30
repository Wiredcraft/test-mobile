@file:Suppress("unused")

package com.fly.audio.databing

import android.view.View
import androidx.databinding.BindingAdapter
import com.fly.audio.databing.onbind.OnClickBinding
import com.fly.audio.databing.onbind.OnTouchBinding

/**
 * Created by likainian on 2021/7/13
 * Description:  自定义view事件绑定
 */

object ViewBinding {

    private const val ON_CLICK = BINDING_PREFIX + "view_onClick"
    private const val ON_TOUCH = BINDING_PREFIX + "view_onTouch"


    @JvmStatic
    @BindingAdapter(ON_CLICK)
    fun setOnClick(view: View?, binding: OnClickBinding) {
        view?.setOnClickListener { binding.block(it) }
    }

    @JvmStatic
    @BindingAdapter(ON_TOUCH)
    fun setOnTouch(view: View, binding: OnTouchBinding) {
        view.setOnTouchListener { v, event ->
            binding.block(v, event)
        }
    }

}

