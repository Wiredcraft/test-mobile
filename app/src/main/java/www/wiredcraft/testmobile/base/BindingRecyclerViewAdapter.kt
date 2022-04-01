package www.wiredcraft.testmobile.base

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.annotation.CallSuper
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding

/**
 *@Description:
 * binding 封装
 * #
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
abstract class BindingRecyclerViewAdapter<VB : ViewBinding> : RecyclerView.Adapter<BindingViewHolder<VB>>() {

    /**
     * @param parent 图层
     * @param viewType  类型
     */
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BindingViewHolder<VB> {
        val viewBinding = onCreateViewBinding(LayoutInflater.from(parent.context), parent, viewType, false)
        return BindingViewHolder(viewBinding)
    }

    /**
     * @param inflater
     * @param root
     * @param viewType
     * @param attachToRoot
     */
    abstract fun onCreateViewBinding(inflater: LayoutInflater, root: ViewGroup?, viewType: Int, attachToRoot: Boolean): VB

    /**
     * @param holder
     * @param position
     */
    @CallSuper
    override fun onBindViewHolder(holder: BindingViewHolder<VB>, position: Int) {
        if (holder.viewBinding is ViewDataBinding) {
            holder.viewBinding.executePendingBindings()
        }
    }
}