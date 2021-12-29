package cn.yohack.wildg.user.ui

import androidx.recyclerview.widget.DiffUtil
import cn.yohack.wildg.R
import cn.yohack.wildg.bean.GithubUser
import cn.yohack.wildg.utils.loadCircle
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.module.LoadMoreModule
import com.chad.library.adapter.base.viewholder.BaseViewHolder

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description user adapter
 **/
class UserAdapter : BaseQuickAdapter<GithubUser, BaseViewHolder>(R.layout.item_user),
    LoadMoreModule {

    init {
        // set diff callback
        setDiffCallback(object : DiffUtil.ItemCallback<GithubUser>() {
            override fun areItemsTheSame(oldItem: GithubUser, newItem: GithubUser): Boolean =
                oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: GithubUser, newItem: GithubUser): Boolean =
                newItem.avatarUrl == oldItem.avatarUrl &&
                        newItem.login == oldItem.login &&
                        newItem.htmlUrl == oldItem.htmlUrl &&
                        newItem.score == oldItem.score

        })
    }

    override fun convert(holder: BaseViewHolder, item: GithubUser) {
        holder.setText(R.id.tv_html, item.htmlUrl)
            .setText(R.id.tv_name, item.login)
            .setText(R.id.tv_score, item.score)
            .loadCircle(R.id.iv_avatar, item.avatarUrl)
    }
}