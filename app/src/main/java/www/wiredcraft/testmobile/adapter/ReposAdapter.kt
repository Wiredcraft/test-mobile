package www.wiredcraft.testmobile.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.ObservableArrayList
import www.wiredcraft.testmobile.api.model.ReposData
import www.wiredcraft.testmobile.base.BindingViewHolder
import www.wiredcraft.testmobile.base.ObservableBindingRecyclerViewAdapter
import www.wiredcraft.testmobile.databinding.ItemReposBinding

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/4/1      onCreate
 */
class ReposAdapter(list: ObservableArrayList<ReposData>, url: String) :
    ObservableBindingRecyclerViewAdapter<ReposData, ItemReposBinding>(list) {

    private val archiveUrl = url

    override fun onCreateViewBinding(
        inflater: LayoutInflater,
        root: ViewGroup?,
        viewType: Int,
        attachToRoot: Boolean
    ): ItemReposBinding {
        return ItemReposBinding.inflate(inflater, root, attachToRoot)

    }

    override fun onBindViewHolderViewBinding(
        holder: BindingViewHolder<ItemReposBinding>,
        position: Int,
        viewBinding: ItemReposBinding,
        item: ReposData
    ) {
        super.onBindViewHolderViewBinding(holder, position, viewBinding, item)

        viewBinding.vm = item
        viewBinding.archiveUrl = archiveUrl
    }

}