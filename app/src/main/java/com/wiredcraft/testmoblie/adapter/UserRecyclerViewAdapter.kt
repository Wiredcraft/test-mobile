package com.wiredcraft.testmoblie.adapter

import android.content.Context
import android.support.v7.widget.CardView
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.wiredcraft.testmoblie.R
import com.wiredcraft.testmoblie.bean.UserBean

/**
 * 列表适配器
 * @author Bruce
 * @date 2020/3/4
 */
class UserRecyclerViewAdapter(private val context: Context,
                              private val userList: List<UserBean>): RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    var isRefreshing: Boolean = true //是否正在刷新
    var isLoadMoreSuccess: Boolean = true //上拉记载更多是否成功

    var onItemClickListener : OnItemClickListener? = null//点击监听接口

    enum class Status(i: Int) {
        DATA(100),//正常的数据
        FOOTER(101),//上拉加载更多
        NO_DATA(102),//没有数据
    }

    private var requestOption = RequestOptions().apply{
        error(R.mipmap.ic_launcher)
        placeholder(R.mipmap.ic_launcher)
        fallback(R.mipmap.ic_launcher)
    }

    /**
     * 正常item的holder
     */
    inner class UserViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var userCardView: CardView = itemView.findViewById(R.id.user_card_view)
        var imageView: ImageView = itemView.findViewById(R.id.image_view)
        var nameText: TextView = itemView.findViewById(R.id.name_text)
        var scoreText: TextView = itemView.findViewById(R.id.score_text)
        var urlText: TextView = itemView.findViewById(R.id.url_text)
    }

    /**
     * 上拉加载更多的holder
     */
    inner class LoadMoreViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var loadingText: TextView = itemView.findViewById(R.id.loading_text)
    }

    /**
     * 无数据空页面holder
     */
    inner class EmptyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var tipsText: TextView = itemView.findViewById(R.id.tips_text)
    }

    override fun getItemViewType(position: Int): Int {
        if (userList.isEmpty()) {
            return Status.NO_DATA.ordinal
        }
        if (position == userList.size) {
            return Status.FOOTER.ordinal
        }
        return Status.DATA.ordinal
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            Status.DATA.ordinal -> { //如果是数据类型，使用正常的用户数据布局
                val view = LayoutInflater.from(context).inflate(R.layout.layout_item, parent, false)
                UserViewHolder(view)
            }
            Status.FOOTER.ordinal -> {//如果是加载更多类型，使用layout_footer布局
                val view = LayoutInflater.from(context).inflate(R.layout.layout_footer, parent, false)
                LoadMoreViewHolder(view)
            }
            else -> { //如果是没有数据，用layout_empty布局
                val view = LayoutInflater.from(context).inflate(R.layout.layout_empty, parent, false)
                EmptyViewHolder(view)
            }
        }
    }

    override fun getItemCount(): Int {
        return userList.size + 1//因为拉到最下面的时候多了一个footer，所以这里+1
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        when {
            getItemViewType(position) == Status.DATA.ordinal -> {//用户数据类型
                val userBean = userList[position]
                var userHolder = holder as UserViewHolder
                userHolder.apply {
                    Glide.with(context)
                            .load(userBean.avatar_url)
                            .apply(requestOption)
                            .into(imageView)
                    nameText.text = userBean.login
                    scoreText.text = userBean.score.toString()
                    urlText.text = userBean.html_url
                    //卡片点击监听
                    userCardView.setOnClickListener {
                        onItemClickListener?.onClick(position)
                    }
                }
            }
            getItemViewType(position) == Status.NO_DATA.ordinal -> {//空数据类型
                var emptyHolder = holder as EmptyViewHolder
                emptyHolder.apply {
                    if (isRefreshing) {
                        tipsText.text = context.resources.getString(R.string.loading)
                    } else {
                        tipsText.text = context.resources.getString(R.string.empty_text)
                    }
                }
            }
            getItemViewType(position) == Status.FOOTER.ordinal -> {//加载更多
                var loadMoreHolder = holder as LoadMoreViewHolder
                loadMoreHolder.apply {
                    if (isLoadMoreSuccess) {
                        loadingText.text = context.resources.getString(R.string.loading)
                    } else {
                        loadingText.text = context.resources.getString(R.string.load_fail)
                    }
                }
            }
        }
    }

    interface OnItemClickListener{
        fun onClick(position: Int)
    }

}
