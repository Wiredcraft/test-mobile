package com.fly.audio.databing.onbind

import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View

/**
 * Created by likainian on 2021/7/13
 * Description:  绑定事件接口
 */

class OnClickBinding(val block: (v: View?) -> Unit)

class OnLongClickBinding(val block: (v: View) -> Boolean)

class OnFocusChangedBinding(val block: (v: View, focus: Boolean) -> Unit)

class OnTouchBinding(val block: (v: View, event: MotionEvent) -> Boolean)

class OnProgressChangedBinding(val block: (progress: Int) -> Unit)

class OnLayoutBinding(val block: (v: View) -> Unit)

class OnPreDrawBinding(val block: (v: View) -> Unit)

class OnGlobalLayoutBinding(val block: (v: View) -> Unit)

class OnKeyBinding(val block: (v: View, keyCode: Int, event: KeyEvent) -> Boolean)
