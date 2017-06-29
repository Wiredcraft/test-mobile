package cn.hakim.animationapplication.view

import android.content.Context
import android.util.DisplayMetrics
import android.view.View
import android.view.WindowManager

object PtrLocalDisplay {

    var SCREEN_WIDTH_PIXELS: Int = 0
    var SCREEN_HEIGHT_PIXELS: Int = 0
    var SCREEN_DENSITY: Float = 0.toFloat()
    var SCREEN_WIDTH_DP: Int = 0
    var SCREEN_HEIGHT_DP: Int = 0

    fun init(context: Context?) {
        if (context == null) {
            return
        }
        val dm = DisplayMetrics()
        val wm = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        wm.defaultDisplay.getMetrics(dm)
        SCREEN_WIDTH_PIXELS = dm.widthPixels
        SCREEN_HEIGHT_PIXELS = dm.heightPixels
        SCREEN_DENSITY = dm.density
        SCREEN_WIDTH_DP = (SCREEN_WIDTH_PIXELS / dm.density).toInt()
        SCREEN_HEIGHT_DP = (SCREEN_HEIGHT_PIXELS / dm.density).toInt()
    }

    fun dp2px(dp: Float): Int {
        val scale = SCREEN_DENSITY
        return (dp * scale + 0.5f).toInt()
    }

    fun designedDP2px(designedDp: Float): Int {
        var designedDp = designedDp
        if (SCREEN_WIDTH_DP != 320) {
            designedDp = designedDp * SCREEN_WIDTH_DP / 320f
        }
        return dp2px(designedDp)
    }

    fun setPadding(view: View, left: Float, top: Float, right: Float, bottom: Float) {
        view.setPadding(designedDP2px(left), dp2px(top), designedDP2px(right), dp2px(bottom))
    }
}
