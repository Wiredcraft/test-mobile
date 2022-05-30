package com.wiredcraft.adapter

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.Animation
import android.view.animation.AnimationUtils
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatTextView
import androidx.navigation.findNavController
import androidx.navigation.fragment.FragmentNavigatorExtras
import androidx.recyclerview.widget.RecyclerView
import com.facebook.drawee.view.SimpleDraweeView
import com.wiredcraft.R
import com.wiredcraft.bean.FollowState
import com.wiredcraft.bean.SearchUser
import com.wiredcraft.bean.UserItem
import com.wiredcraft.database.AppDatabase
import com.wiredcraft.databinding.FragmentSearchUserRecyclerViewItemBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking

class SearchUserRecyclerViewAdapter(
    var dataSource: SearchUser
) : RecyclerView.Adapter<SearchUserRecyclerViewAdapter.ViewHolder>() {
    override fun getItemCount(): Int {
        return dataSource.items.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.onBind(dataSource.items[position])
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
        RecyclerView.ViewHolder(binding.root), View.OnClickListener {
        private val name: AppCompatTextView = binding.name
        private val score: AppCompatTextView = binding.score
        private val url: AppCompatTextView = binding.url
        private val avatar: SimpleDraweeView = binding.avatar
        private val follow: AppCompatButton = binding.follow
        private lateinit var item: UserItem
        val animation: Animation =
            AnimationUtils.loadAnimation(itemView.context, R.anim.item_animation_fall)

        init {
            itemView.setOnClickListener(this)
            follow.setOnClickListener(this)
        }

        fun onBind(item: UserItem) {
            this.item = item
            name.text = item.login
            score.text = item.score.toString()
            url.text = item.html_url
            avatar.setImageURI(item.avatar_url)
            if (item.followState) {
                follow.setText(R.string.followed)
            } else {
                follow.setText(R.string.follow)
            }
        }

        override fun onClick(v: View) {
            if (v.id == R.id.follow) {
                item.followState = !item.followState
                if (item.followState) {
                    follow.setText(R.string.followed)
                } else {
                    follow.setText(R.string.follow)
                }
                runBlocking(Dispatchers.IO) {
                    AppDatabase.getInstance().userDao()
                        .insertOrUpdate(FollowState(item.id, item.followState))
                }
            } else {
                // RecyclerView ItemView具有相同的transitionName，不可以设置在xml中
                avatar.transitionName = layoutPosition.toString()
                v.findNavController().navigate(
                    // navigation safe args TODO
                    R.id.action_search_user_fragment_to_repos_fragment,
                    Bundle().apply { putParcelable("userItem", item) },
                    null,
                    FragmentNavigatorExtras(avatar to "avatar")
                )
            }
        }
    }

    override fun onViewAttachedToWindow(holder: ViewHolder) {
        holder.itemView.startAnimation(holder.animation)
    }

    override fun onViewDetachedFromWindow(holder: ViewHolder) {
        holder.itemView.clearAnimation()
    }
}
