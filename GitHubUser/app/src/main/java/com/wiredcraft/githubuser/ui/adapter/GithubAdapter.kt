package com.wiredcraft.githubuser.ui.adapter

import android.graphics.Color
import android.widget.ImageView
import android.widget.TextView
import coil.load
import coil.transform.CircleCropTransformation
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.module.LoadMoreModule
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.wiredcraft.githubuser.R
import com.wiredcraft.githubuser.data.model.Item

class GithubAdapter : BaseQuickAdapter<Item, BaseViewHolder>(R.layout.item_user),
    LoadMoreModule {

    init {
        addChildClickViewIds(R.id.clUser, R.id.tvFollow)
    }

    override fun convert(holder: BaseViewHolder, item: Item) {
        item.apply {
            holder.getView<ImageView>(R.id.ivAvatar).load(item.avatar_url) {
                placeholder(R.drawable.default_avatar)
                error(R.drawable.default_avatar)
                transformations(CircleCropTransformation())
            }
            item.isFollow.let {
                holder.getView<TextView>(R.id.tvFollow).isSelected = it
                when (it) {
                    true -> {
                        holder.getView<TextView>(R.id.tvFollow)
                            .setTextColor(Color.parseColor("#000000"))
                        holder.setText(R.id.tvFollow, "已关注")
                    }
                    false -> {
                        holder.getView<TextView>(R.id.tvFollow)
                            .setTextColor(Color.parseColor("#FFFFFF"))
                        holder.setText(R.id.tvFollow, "关注")
                    }
                }
            }

            holder.setText(R.id.tvNickName, item.login)
            holder.setText(R.id.tvScore, item.score.toString())
            holder.setText(R.id.tvHtmlAddress, item.html_url)
        }
    }
}