package com.wiredcraft.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatTextView
import androidx.recyclerview.widget.RecyclerView
import com.facebook.drawee.view.SimpleDraweeView
import com.wiredcraft.bean.UserReposInfo
import com.wiredcraft.databinding.FragmentSearchUserRecyclerViewItemBinding

class ReposRecyclerViewAdapter(
    var dataSource: ArrayList<UserReposInfo> = ArrayList(0)
) : RecyclerView.Adapter<ReposRecyclerViewAdapter.ViewHolder>() {
    override fun getItemCount(): Int {
        return dataSource.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.onBind(dataSource[position])
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(
            FragmentSearchUserRecyclerViewItemBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    inner class ViewHolder(binding: FragmentSearchUserRecyclerViewItemBinding) :
        RecyclerView.ViewHolder(binding.root) {
        private val name: AppCompatTextView = binding.name
        private val score: AppCompatTextView = binding.score
        private val url: AppCompatTextView = binding.url
        private val avatar: SimpleDraweeView = binding.avatar
        private val follow: AppCompatButton = binding.follow
        private lateinit var item: UserReposInfo

        init {
            follow.visibility = View.GONE
        }

        fun onBind(item: UserReposInfo) {
            this.item = item
            name.text = item.name
            score.text = item.stargazers_count.toString()
            url.text = item.html_url
            avatar.setImageURI(item.owner.avatar_url)
        }
    }
}
