package com.example.testmobile

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.testmobile.databinding.ItemGithubUserBinding
import com.example.testmobile.model.GithubUser

class GithubUserAdapter(
    private val homeViewModel: HomeViewModel,
    private val lifecycleOwner: LifecycleOwner,
    private val onClickCallback: (user: GithubUser?) -> Unit
) :
    ListAdapter<GithubUser, GithubUserAdapter.UserItemViewHolder>(TaskDiffCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserItemViewHolder {
        return UserItemViewHolder(
            ItemGithubUserBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            ), lifecycleOwner
        )
    }

    override fun onBindViewHolder(holder: UserItemViewHolder, position: Int) {
        holder.bind(homeViewModel, getItem(position))
    }

    inner class UserItemViewHolder(
        private val binding: ItemGithubUserBinding,
        private val lifecycleOwner: LifecycleOwner
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(viewModel: HomeViewModel, item: GithubUser?) {
            binding.lifecycleOwner = lifecycleOwner
            binding.user = item
            binding.root.setOnClickListener {
                onClickCallback.invoke(item)
            }
            binding.executePendingBindings()
        }
    }

    class TaskDiffCallback : DiffUtil.ItemCallback<GithubUser>() {
        override fun areItemsTheSame(oldItem: GithubUser, newItem: GithubUser): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(oldItem: GithubUser, newItem: GithubUser): Boolean {
            return oldItem.avatarUrl == newItem.avatarUrl
                    && oldItem.name == newItem.name
                    && oldItem.score == newItem.score
                    && oldItem.htmlUrl == newItem.htmlUrl
        }
    }

}
