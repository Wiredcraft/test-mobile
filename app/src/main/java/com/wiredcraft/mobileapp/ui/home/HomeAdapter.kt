package com.wiredcraft.mobileapp.ui.home

import android.widget.ImageView
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.wiredcraft.mobileapp.R
import com.wiredcraft.mobileapp.bean.UserBean
import com.wiredcraft.mobileapp.ext.circle

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the adapter of homepage
 *
 */
class HomeAdapter: BaseQuickAdapter<UserBean, BaseViewHolder>(R.layout.item_user_common) {
    override fun convert(holder: BaseViewHolder, item: UserBean) {
        holder.getView<ImageView>(R.id.iv_item_avatar).run {
            circle(this, item.avatarUrl)
        }
        holder.setText(R.id.tv_item_name, item.userName)
        holder.setText(R.id.tv_item_score, "${item.score}")
        holder.setText(R.id.tv_item_url, item.url)
        val followText = if (item.isFollowed) {
            context.resources.getString(R.string.str_followed)
        } else {
            context.resources.getString(R.string.str_follow)
        }
        holder.setText(R.id.tv_follow, followText)
    }
}