package com.fly.audio.adapter

import androidx.databinding.DataBindingUtil
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.fly.audio.R
import com.fly.audio.databinding.ItemUserBinding
import com.fly.audio.model.UserBean
import com.fly.core.webview.WebActivity

/**
 * Created by likainian on 2021/8/31
 * Description:
 */

class UserAdapter : BaseQuickAdapter<UserBean, BaseViewHolder>(R.layout.item_user) {

    override fun onItemViewHolderCreated(viewHolder: BaseViewHolder, viewType: Int) {
        DataBindingUtil.bind<ItemUserBinding>(viewHolder.itemView)
    }
    override fun convert(helper: BaseViewHolder, item: UserBean) {
        val binding = helper.getBinding<ItemUserBinding>()
        binding?.user = item
        binding?.root?.setOnClickListener {
            WebActivity.startActivity(binding.root.context,item.html_url)
        }
    }
}