package com.aric.finalweather.adapter

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.aric.finalweather.R
import com.aric.finalweather.databinding.ItemRepoInfoBinding
import com.aric.repository.RepoInfo

class RepoListAdapter() :
    ListAdapter<RepoInfo, RepoListAdapter.ViewHolder>(diffCallback) {
    companion object {
        val diffCallback = object : DiffUtil.ItemCallback<RepoInfo>() {
            override fun areItemsTheSame(
                oldItem: RepoInfo,
                newItem: RepoInfo
            ): Boolean {
                return oldItem.id == newItem.id
            }

            override fun areContentsTheSame(
                oldItem: RepoInfo,
                newItem: RepoInfo
            ): Boolean {
                return oldItem.id == newItem.id
            }
        }
    }

    class ViewHolder( val binding: ItemRepoInfoBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding: ItemRepoInfoBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context),
            R.layout.item_repo_info,
            parent,
            false
        )
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = getItem(position)
        holder.binding.repoInfo = item
    }
}