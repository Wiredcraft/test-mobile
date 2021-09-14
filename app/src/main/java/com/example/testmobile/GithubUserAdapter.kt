package com.example.testmobile

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.lifecycle.LifecycleOwner
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.example.testmobile.databinding.ItemGithubUserBinding
import com.example.testmobile.model.GithubUser

class GithubUserAdapter(
    private val lifecycleOwner: LifecycleOwner,
    private val onClickCallback: (user: GithubUser?) -> Unit
) :
    RecyclerView.Adapter<GithubUserAdapter.UserItemViewHolder>() {

    private val mData = mutableListOf<GithubUser>()

    fun refreshData(data: List<GithubUser>?) {
        val oldSize = mData.size
        mData.clear()
        notifyItemRangeRemoved(0, oldSize)
        data?.let {
            mData.addAll(data)
        }
        notifyItemRangeInserted(0, mData.size)
    }

    fun appendData(data: List<GithubUser>?) {
        val positionStart = mData.size
        data?.let {
            mData.addAll(data)
        }
        notifyItemRangeInserted(positionStart, data?.size ?: 0)
    }

    override fun getItemCount(): Int {
        return mData.size
    }

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
        holder.bind(mData[position])
    }

    inner class UserItemViewHolder(
        private val binding: ItemGithubUserBinding,
        private val lifecycleOwner: LifecycleOwner
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(item: GithubUser?) {
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
