package com.seazon.qrgenerator.utils

import android.animation.Animator
import android.animation.ObjectAnimator
import android.view.View
import android.view.animation.DecelerateInterpolator
import android.view.animation.Interpolator
import android.view.animation.OvershootInterpolator

/**
 * Created by seazon on 2018/3/9.
 */
object AnimationUtils {

    fun rotate(view: View, fromDegrees: Float, toDegrees: Float) {
        val animator = ObjectAnimator.ofFloat(view, "rotation", fromDegrees, toDegrees)
        val lin = DecelerateInterpolator()
        animator.interpolator = lin
        animator.duration = 200
        animator.start()
    }

    fun move(view: View, fromYDelta: Float, toYDelta: Float, overshoot: Boolean, callback: () -> Unit = {}) {
        val animator = ObjectAnimator.ofFloat(view, "translationY", fromYDelta, toYDelta)
        val lin: Interpolator = if (overshoot) {
            OvershootInterpolator()
        } else {
            DecelerateInterpolator()
        }
        animator.interpolator = lin
        animator.duration = 200
        animator.addListener(object : Animator.AnimatorListener {
            override fun onAnimationRepeat(animation: Animator) {
            }

            override fun onAnimationEnd(animation: Animator) {
                callback()
            }

            override fun onAnimationCancel(animation: Animator) {
            }

            override fun onAnimationStart(animation: Animator) {
            }
        })
        animator.start()
    }

}