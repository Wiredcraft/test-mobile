package xyz.mengxy.githubuserslist.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import xyz.mengxy.githubuserslist.databinding.ViewItemInfoBinding
import xyz.mengxy.githubuserslist.model.Repo

/**
 * Created by Mengxy on 3/30/22.
 * repo paging data adapter in user detail page
 */
class RepoAdapter : PagingDataAdapter<Repo, RepoAdapter.RepoViewHolder>(RepoDiffCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RepoViewHolder {
        return RepoViewHolder(
            ViewItemInfoBinding.inflate(
                LayoutInflater.from(parent.context),
                parent, false
            )
        )
    }

    override fun onBindViewHolder(holder: RepoViewHolder, position: Int) {
        getItem(position)?.let {
            holder.bind(it)
        }
    }

    class RepoViewHolder(
        private val binding: ViewItemInfoBinding
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(item: Repo) {
            binding.apply {
                info = item
                executePendingBindings()
            }
        }
    }
}

private class RepoDiffCallback : DiffUtil.ItemCallback<Repo>() {
    override fun areItemsTheSame(oldItem: Repo, newItem: Repo): Boolean {
        return oldItem.repoId == newItem.repoId
    }

    override fun areContentsTheSame(oldItem: Repo, newItem: Repo): Boolean {
        return oldItem == newItem
    }

}
