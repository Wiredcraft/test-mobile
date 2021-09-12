package com.andzhv.githubusers.utils.ex

import android.app.Activity
import android.graphics.Rect
import android.view.ViewTreeObserver
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/12.
 */
fun Activity.observeKeyboardChange(): Observable<Boolean> {
    val rootView = this.window.decorView
    val r = Rect()
    var lastHeight = 0
    return Observable.create { emitter ->
        val listener = ViewTreeObserver.OnGlobalLayoutListener {
            rootView.getWindowVisibleDisplayFrame(r)
            val height = r.height()
            if (lastHeight == 0) {
                lastHeight = height
            } else {
                val diff = lastHeight - height
                if (diff > 0) {
                    emitter.onNext(true)
                    lastHeight = height
                } else if (diff < 0) {
                    emitter.onNext(false)
                    lastHeight = height
                }
            }
        }
        rootView.viewTreeObserver.addOnGlobalLayoutListener(listener)
        emitter.setCancellable { rootView.viewTreeObserver.removeOnGlobalLayoutListener(listener) }
    }
}