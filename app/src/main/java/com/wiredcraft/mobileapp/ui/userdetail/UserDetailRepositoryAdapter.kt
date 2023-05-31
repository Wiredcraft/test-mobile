package com.wiredcraft.mobileapp.ui.userdetail

import android.widget.ImageView
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.wiredcraft.mobileapp.R
import com.wiredcraft.mobileapp.bean.RepositoryBean
import com.wiredcraft.mobileapp.ext.circle

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the adapter for userDetail
 *
 */
class UserDetailRepositoryAdapter : BaseQuickAdapter<RepositoryBean, BaseViewHolder>(R.layout.item_user_common) {
    override fun convert(holder: BaseViewHolder, item: RepositoryBean) {
        holder.setGone(R.id.tv_follow, true)
        holder.getView<ImageView>(R.id.iv_item_avatar).run {
            circle(this, item.avatarUrl)
        }
        holder.setText(R.id.tv_item_name, item.repositoryName)
        holder.setText(R.id.tv_item_score, "${item.score}")
        holder.setText(R.id.tv_item_url, item.url)
    }
}