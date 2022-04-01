package www.wiredcraft.testmobile.base

import android.annotation.SuppressLint
import androidx.databinding.ObservableList
import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
abstract class ObservableBindingRecyclerViewAdapter<E, VB : ViewBinding>(
    private val dataList: ObservableList<E>
) : BindingRecyclerViewAdapter<VB>() {

    private val dataListChangedCallback: DataListChangedCallback = DataListChangedCallback()

    /**
     * 绑定 holder
     * @param holder
     * @param position
     */
    override fun onBindViewHolder(holder: BindingViewHolder<VB>, position: Int) {
        super.onBindViewHolder(holder, position)
        onBindViewHolderViewBinding(holder, position, holder.viewBinding,
            dataList[getDataItemPosition(position)])
    }

    /**
     * 关于绑定视图持有者视图绑定
     * @param holder
     * @param position
     * @param viewBinding
     * @param item
     */
    open fun onBindViewHolderViewBinding(holder: BindingViewHolder<VB>, position: Int,
                                         viewBinding: VB, item: E) {

    }

    /**
     * 获取数据项位置
     * @param listPosition
     */
    open fun getDataItemPosition(listPosition: Int): Int {
        return listPosition
    }

    /**
     * 关于绑定视图持有者
     * @param holder
     * @param position
     * @param payloads
     */
    override fun onBindViewHolder(holder: BindingViewHolder<VB>, position: Int, payloads: MutableList<Any>) {
        super.onBindViewHolder(holder, position, payloads)
        onBindViewHolderViewBinding(holder, position,
            holder.viewBinding, dataList[getDataItemPosition(position)], payloads)
    }

    /**
     * 关于绑定视图持有者视图绑定
     * @param holder
     * @param position
     * @param viewBinding
     * @param item
     * @param payloads
     */
    open fun onBindViewHolderViewBinding(holder: BindingViewHolder<VB>, position: Int,
                                         viewBinding: VB, item: E, payloads: MutableList<Any>) {
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)
        dataList.addOnListChangedCallback(dataListChangedCallback)
    }

    override fun onDetachedFromRecyclerView(recyclerView: RecyclerView) {
        super.onDetachedFromRecyclerView(recyclerView)
        dataList.removeOnListChangedCallback(dataListChangedCallback)
    }

    override fun getItemCount() = dataList.size

    /**
     * 数据列表已更改回调
     *
     */
    @SuppressLint("NotifyDataSetChanged")
    private inner class DataListChangedCallback : ObservableList.OnListChangedCallback<ObservableList<E>>() {

        override fun onChanged(sender: ObservableList<E>?) {
            this@ObservableBindingRecyclerViewAdapter.notifyDataSetChanged()
        }

        override fun onItemRangeChanged(sender: ObservableList<E>?, positionStart: Int, itemCount: Int) {
            this@ObservableBindingRecyclerViewAdapter.notifyItemRangeChanged(positionStart, itemCount)
        }

        override fun onItemRangeInserted(sender: ObservableList<E>?, positionStart: Int, itemCount: Int) {
            this@ObservableBindingRecyclerViewAdapter.notifyItemRangeInserted(positionStart, itemCount)
        }

        override fun onItemRangeMoved(sender: ObservableList<E>?, fromPosition: Int, toPosition: Int, itemCount: Int) {
            this@ObservableBindingRecyclerViewAdapter.notifyDataSetChanged()
        }

        override fun onItemRangeRemoved(sender: ObservableList<E>?, positionStart: Int, itemCount: Int) {
            this@ObservableBindingRecyclerViewAdapter.notifyItemRangeRemoved(positionStart, itemCount)
        }

    }

}