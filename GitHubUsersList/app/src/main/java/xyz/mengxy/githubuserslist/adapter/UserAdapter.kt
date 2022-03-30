package xyz.mengxy.githubuserslist.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.navigation.findNavController
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import xyz.mengxy.githubuserslist.R
import xyz.mengxy.githubuserslist.databinding.ViewItemInfoBinding
import xyz.mengxy.githubuserslist.model.User
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel

/**
 * Created by Mengxy on 3/29/22.
 */
class UserAdapter(private val userDetailViewModel: UserDetailViewModel) :
    PagingDataAdapter<User, UserAdapter.UserViewHolder>(UserDiffCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        return UserViewHolder(
            ViewItemInfoBinding.inflate(
                LayoutInflater.from(parent.context), parent, false
            )
        )
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        getItem(position)?.let {
            holder.bind(userDetailViewModel, it)
        }
    }

    class UserViewHolder(
        private val binding: ViewItemInfoBinding
    ) : RecyclerView.ViewHolder(binding.root) {

        fun bind(viewModel: UserDetailViewModel, item: User) {
            binding.apply {
                info = item
                setClickListener {
                    viewModel.setUserInfo(item)
                    it.findNavController()
                        .navigate(R.id.action_userListFragment_to_userDetailFragment)
                }
                setFollowListener {
                    //todo follow click
                }
                executePendingBindings()
            }
        }

    }

}

private class UserDiffCallback : DiffUtil.ItemCallback<User>() {
    override fun areItemsTheSame(oldItem: User, newItem: User): Boolean {
        return oldItem.userId == newItem.userId
    }

    override fun areContentsTheSame(oldItem: User, newItem: User): Boolean {
        return oldItem == newItem
    }

}
