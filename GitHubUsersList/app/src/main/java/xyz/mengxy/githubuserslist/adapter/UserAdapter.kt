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
import xyz.mengxy.githubuserslist.util.PAYLOAD_UPDATE_FOLLOW_STATE
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel

/**
 * Created by Mengxy on 3/29/22.
 * user paging data adapter in user list page
 * [UserDetailViewModel] to store the user data when click item and deal with follow action
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

    // only update follow state TextView
    override fun onBindViewHolder(
        holder: UserViewHolder,
        position: Int,
        payloads: MutableList<Any>
    ) {
        if (payloads.isEmpty()) {
            onBindViewHolder(holder, position)
        } else {
            if (PAYLOAD_UPDATE_FOLLOW_STATE == (payloads[0] as? String)) {
                getItem(position)?.let {
                    holder.bindFollow(it)
                }
            }
        }
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
                    // open user detail page with navigate()
                    it.findNavController()
                        .navigate(R.id.action_userListFragment_to_userDetailFragment)
                }
                setFollowListener {
                    viewModel.followUser(item)
                }
                executePendingBindings()
            }
        }

        fun bindFollow(item: User) {
            binding.apply {
                tvFollowButton.text =
                    binding.root.resources.getString(
                        if (item.isFollowed) {
                            R.string.text_followed
                        } else {
                            R.string.text_follow
                        }
                    )
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
