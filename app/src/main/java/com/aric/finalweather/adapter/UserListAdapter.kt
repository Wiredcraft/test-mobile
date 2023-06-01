package com.aric.finalweather.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.aric.finalweather.R
import com.aric.finalweather.databinding.ItemUserinfoBinding
import com.aric.repository.UserInfo

class UserListAdapter(inline val onItemClick:(user:UserInfo)->Unit,inline val onSubscribeClick:(user:UserInfo)->Unit) :
    ListAdapter<UserInfo, UserListAdapter.ViewHolder>(diffCallback) {

    companion object {
        val diffCallback = object : DiffUtil.ItemCallback<UserInfo>() {
            override fun areItemsTheSame(
                oldItem: UserInfo,
                newItem: UserInfo
            ): Boolean {
                return oldItem.login == newItem.login
            }

            override fun areContentsTheSame(
                oldItem: UserInfo,
                newItem: UserInfo
            ): Boolean {
                return oldItem.follow == newItem.follow
            }
        }
    }

    class ViewHolder( val binding: ItemUserinfoBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding: ItemUserinfoBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context),
            R.layout.item_userinfo,
            parent,
            false
        )
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = getItem(position)
        holder.binding.userInfo = item
        holder.itemView.setOnClickListener{
            onItemClick(item)
        }
        holder.binding.subscribe.setOnClickListener {
            onSubscribeClick(item)
        }
    }
}