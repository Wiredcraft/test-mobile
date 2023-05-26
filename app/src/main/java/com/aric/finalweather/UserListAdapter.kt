package com.aric.finalweather

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.aric.finalweather.databinding.ItemUserinfoBinding
import com.aric.repository.UserInfo

class UserListAdapter :
    ListAdapter<UserInfo, UserListAdapter.ViewHolder>(diffCallback) {

    companion object {
        val diffCallback = object : DiffUtil.ItemCallback<UserInfo>() {
            override fun areItemsTheSame(
                oldItem: UserInfo,
                newItem: UserInfo
            ): Boolean {
                return oldItem.id == newItem.id
            }

            override fun areContentsTheSame(
                oldItem: UserInfo,
                newItem: UserInfo
            ): Boolean {
                return oldItem.id == newItem.id
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
        Log.d("aric","-----onBindViewHolder-------")
        holder.binding.userInfo = getItem(position)
    }
}