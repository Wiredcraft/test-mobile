package cn.yohack.wildg.base.dialog

import android.app.Dialog
import android.content.Context
import android.view.View
import cn.yohack.wildg.R

/**
 * @Author yo_hack
 * @Date 2021.11.25
 * @Description
 **/

fun showLoadingDialog(context: Context?, msg: String? = null): Dialog? {
    if (context == null) {
        return null
    }

    val dialog = Dialog(context, R.style.loading)
    val root = View.inflate(context, R.layout.dialog_loading, null)
    dialog.setContentView(root)
    dialog.setCancelable(true)
    dialog.setCanceledOnTouchOutside(false)
    dialog.show()
    return dialog
}
