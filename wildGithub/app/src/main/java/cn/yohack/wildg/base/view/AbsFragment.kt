package cn.yohack.wildg.base.view

import android.app.Dialog
import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner
import cn.yohack.wildg.base.dialog.showLoadingDialog
import cn.yohack.wildg.utils.showMsg

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description 基础的 abs Fragment  可能没有 rootView
 **/
open class AbsFragment : Fragment(), ILoadAndToastEvent {

    override fun getLOwner(): LifecycleOwner = viewLifecycleOwner

    private var dialog: Dialog? = null
    override fun showLoading(msg: String?) {
        if (dialog == null) {
            dialog = showLoadingDialog(context, msg)
        } else {
            if (dialog?.isShowing != true) {
                dialog?.show()
            }
        }
    }

    override fun dismissLoading() {
        dialog?.dismiss()
    }

    override fun showToast(msg: String?) {
        showMsg(msg)
    }

    override fun onDestroyView() {
        dismissLoading()
        super.onDestroyView()
    }
}