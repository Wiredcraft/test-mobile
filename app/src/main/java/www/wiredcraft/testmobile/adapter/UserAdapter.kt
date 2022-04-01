package www.wiredcraft.testmobile.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.ObservableArrayList
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.base.BindingViewHolder
import www.wiredcraft.testmobile.base.ObservableBindingRecyclerViewAdapter
import www.wiredcraft.testmobile.databinding.ItemUserBinding
import www.wiredcraft.testmobile.interfaces.MainModelInterface

/**
 *@Description:
 * #用户搜索适配器
 * @param list 绑定的数据
 * #0000      @Author: tianxiao     2022/3/31      onCreate
 */
class UserAdapter(var list: ObservableArrayList<Item>) :
    ObservableBindingRecyclerViewAdapter<Item, ItemUserBinding>(list) {

    var interfaces: MainModelInterface? = null

    override fun onCreateViewBinding(
        inflater: LayoutInflater,
        root: ViewGroup?,
        viewType: Int,
        attachToRoot: Boolean
    ): ItemUserBinding {
        return ItemUserBinding.inflate(inflater, root, attachToRoot)
    }

    override fun onBindViewHolderViewBinding(
        holder: BindingViewHolder<ItemUserBinding>,
        position: Int,
        viewBinding: ItemUserBinding,
        item: Item
    ) {
        super.onBindViewHolderViewBinding(holder, position, viewBinding, item)
        viewBinding.vm = item
        viewBinding.itemLayout.setOnClickListener {
            interfaces?.StartActivityUserDetailsForResult(item,position)
        }
    }

}