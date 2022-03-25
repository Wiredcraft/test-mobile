package com.wiredcraft.example.ui.adapter

import com.chad.library.adapter.base.BaseQuickAdapter
import com.wiredcraft.example.entity.Repo
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.chad.library.adapter.base.module.LoadMoreModule
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import com.chad.library.adapter.base.module.BaseLoadMoreModule
import com.wiredcraft.example.R
import com.wiredcraft.example.databinding.ItemRepoBinding

/**
 * @author 武玉朋
 */
class RepoAdapter : BaseQuickAdapter<Repo, BaseViewHolder>(R.layout.item_repo), LoadMoreModule {
    override fun onCreateDefViewHolder(parent: ViewGroup, viewType: Int): BaseViewHolder {
        return super.onCreateDefViewHolder(parent, viewType)
    }

    override fun onItemViewHolderCreated(viewHolder: BaseViewHolder, viewType: Int) {
        DataBindingUtil.bind<ViewDataBinding>(viewHolder.itemView)
    }

    override fun convert(helper: BaseViewHolder, item: Repo) {
        val binding: ItemRepoBinding = helper.getBinding()!!
        binding.repo = item
        binding.executePendingBindings()
    }

    override fun addLoadMoreModule(baseQuickAdapter: BaseQuickAdapter<*, *>): BaseLoadMoreModule {
        return BaseLoadMoreModule(baseQuickAdapter)
    }
}