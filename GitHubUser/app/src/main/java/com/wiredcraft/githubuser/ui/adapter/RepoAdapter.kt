package com.wiredcraft.githubuser.ui.adapter

import android.widget.ImageView
import coil.load
import coil.transform.CircleCropTransformation
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.wiredcraft.githubuser.R
import com.wiredcraft.githubuser.data.model.UserRepos

class RepoAdapter : BaseQuickAdapter<UserRepos, BaseViewHolder>(R.layout.item_repo) {
    override fun convert(holder: BaseViewHolder, item: UserRepos) {
        holder.getView<ImageView>(R.id.ivAvatar).load(item.owner.avatar_url) {
            placeholder(R.drawable.default_avatar)
            error(R.drawable.default_avatar)
            transformations(CircleCropTransformation())
        }
        holder.setText(R.id.tvNickName, item.name)
        holder.setText(R.id.tvScore, item.stargazers_count.toString())
        holder.setText(R.id.tvHtmlAddress, item.html_url)
    }
}