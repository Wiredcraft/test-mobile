package com.caizhixng.githubapidemo

import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder

/**
 * czx 2021/9/11
 */
class UserAdapter : BaseQuickAdapter<MockUser, BaseViewHolder>(R.layout.item_user) {

    override fun convert(holder: BaseViewHolder, user: MockUser) {
        holder.setText(R.id.user_name, user.userName)
        holder.setText(R.id.user_score, user.userScore)
        holder.setText(R.id.user_url, user.userUrl)
    }

}