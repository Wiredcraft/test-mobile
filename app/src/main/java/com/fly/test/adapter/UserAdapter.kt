package com.fly.test.adapter

import androidx.databinding.DataBindingUtil
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.fly.test.R
import com.fly.test.databinding.ItemUserBinding
import com.fly.test.model.UserBean

/**
 * Created by likainian on 2021/8/31
 * Description: 用户列表
 */

class UserAdapter : BaseQuickAdapter<UserBean, BaseViewHolder>(R.layout.item_user) {

    //用户列表点击回调
    var onClickItem: ((item: UserBean) -> Unit)? = null

    override fun onItemViewHolderCreated(viewHolder: BaseViewHolder, viewType: Int) {
        DataBindingUtil.bind<ItemUserBinding>(viewHolder.itemView)
    }

    override fun convert(helper: BaseViewHolder, item: UserBean) {
        val binding = helper.getBinding<ItemUserBinding>()
        binding?.user = item
        binding?.root?.setOnClickListener {
            onClickItem?.invoke(item)
        }
    }
}