package com.wiredcraft.testmoblie.adapter

import android.content.Context
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
    private val TYPE_DATA = 0//正常的item
    private val TYPE_FOOTER = 1//上拉加载
    private val TYPE_EMPTY = 2//空页面

    private var requestOption = RequestOptions().apply{
        error(R.mipmap.ic_launcher)
        placeholder(R.mipmap.ic_launcher)
        fallback(R.mipmap.ic_launcher)
    }

    /**
     * 正常item的holder
     */
    inner class UserViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
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

    override fun getItemViewType(position: Int): Int {
        if (userList.isEmpty()) {
            return TYPE_EMPTY
        }
        if (position == userList.size) {
            return TYPE_FOOTER
        }
        return TYPE_DATA
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            TYPE_DATA -> {
                val view = LayoutInflater.from(context).inflate(R.layout.layout_item, parent, false)
                UserViewHolder(view)
            }
            TYPE_FOOTER -> {
                val view = LayoutInflater.from(context).inflate(R.layout.layout_footer, parent, false)
                LoadMoreViewHolder(view)
            }
            else -> {
                val view = LayoutInflater.from(context).inflate(R.layout.layout_footer, parent, false)
                LoadMoreViewHolder(view)
            }
        }
    }

    override fun getItemCount(): Int {
        return userList.size + 1//因为拉到最下面的时候多了一个footer，所以这里+1
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (getItemViewType(position) == TYPE_DATA) {
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
            }
        }
    }

}
