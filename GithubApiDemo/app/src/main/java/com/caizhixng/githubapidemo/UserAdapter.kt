package com.caizhixng.githubapidemo

import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CircleCrop
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.module.LoadMoreModule
import com.chad.library.adapter.base.viewholder.BaseViewHolder

/**
 * czx 2021/9/11
 */
class UserAdapter : BaseQuickAdapter<User, BaseViewHolder>(R.layout.item_user), LoadMoreModule {

    override fun convert(holder: BaseViewHolder, user: User) {
        holder.setText(R.id.user_name, user.userName)
        holder.setText(R.id.user_score, user.userScore)
        holder.setText(R.id.user_url, user.userUrl)

        Glide.with(holder.itemView).load(user.userUrl)
            .placeholder(R.drawable.ic_baseline_account_circle)
            .error(R.drawable.ic_baseline_account_circle)
            .transform(CircleCrop())
            .into(holder.getView(R.id.user_avatar))
    }

}