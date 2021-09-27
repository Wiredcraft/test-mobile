package com.testmobile.githubuserslist.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import com.google.android.material.appbar.AppBarLayout
import com.testmobile.githubuserslist.R
import com.testmobile.githubuserslist.databinding.ItemUserBinding
import com.testmobile.githubuserslist.model.User
import com.thefinestartist.finestwebview.FinestWebView

/**
 * Users list adapter to be bind to the recyclerview to display list of users
 * params -> context?: optional
 * */
class UsersAdapter(private val context: Context?):
    PagingDataAdapter<User, UsersAdapter.UserViewHolder>(USER_COMPARATOR) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserViewHolder {
        val binding = ItemUserBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return UserViewHolder(binding)
    }

    override fun onBindViewHolder(holder: UserViewHolder, position: Int) {
        val currentItem = getItem(position)

        if (currentItem != null) {
            holder.bind(currentItem)
        }
    }

    inner class UserViewHolder(private val binding: ItemUserBinding)
        :RecyclerView.ViewHolder(binding.root){

        // set onclick listener for each view item
            init {
                binding.root.setOnClickListener{
                    val position = bindingAdapterPosition
                    if (position != RecyclerView.NO_POSITION) {
                        val item = getItem(position)
                        if (item != null && context != null) {
                            FinestWebView.Builder(context)
                                .titleDefault("Details")
                                .toolbarScrollFlags(AppBarLayout.LayoutParams.SCROLL_FLAG_SCROLL)
                                .gradientDivider(false)
                                .dividerHeight(100)
                                .iconPressedColorRes(R.color.black)
                                .progressBarColorRes(R.color.green_200)
                                .backPressToClose(false)
                                .setCustomAnimations(R.anim.activity_open_enter, R.anim.activity_open_exit, R.anim.activity_close_enter, R.anim.activity_close_exit)
                                .show(item.url);

                        }
                    }
                }
            }

        // bind the views and update the display
        fun bind(user: User) {
            binding.apply {
                //load user image into imageview
                Glide.with(itemView)
                    .load(user.avatarUrl)
                    .centerCrop()
                    .transition(DrawableTransitionOptions.withCrossFade())
                    .error(R.drawable.ic_baseline_error_outline_24)
                    .into(avatarImageView)

                textviewName.text = user.name
                textviewScore.text = user.score
                textviewUrl.text = user.url
            }
        }

    }

    companion object {
        /**
         * Used to calculate update for the [RecyclerView]
         * */
        private val USER_COMPARATOR = object : DiffUtil.ItemCallback<User>() {
            override fun areItemsTheSame(oldItem: User, newItem: User) =
                oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: User, newItem: User) =
                oldItem == newItem
        }
    }

}