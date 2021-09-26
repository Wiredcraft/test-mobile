package com.testmobile.githubuserslist.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.view.isVisible
import androidx.paging.LoadState
import androidx.paging.LoadStateAdapter
import androidx.recyclerview.widget.RecyclerView
import com.testmobile.githubuserslist.databinding.UserLoadStateFooterBinding

/**
 * [UserLoadStateAdapter] is bind to the footer of the recyclerview
 * to display the state of the paged results
 * */
class UserLoadStateAdapter(private val retry: () -> Unit) :
    LoadStateAdapter<UserLoadStateAdapter.LoadStateViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, loadState: LoadState): LoadStateViewHolder {
        val binding = UserLoadStateFooterBinding.inflate(
            LayoutInflater.from(parent.context),
            parent,
            false
        )

        return LoadStateViewHolder(binding)
    }

    override fun onBindViewHolder(holder: LoadStateViewHolder, loadState: LoadState) {
        holder.bind(loadState)
    }

    inner class LoadStateViewHolder(private val binding: UserLoadStateFooterBinding) :
        RecyclerView.ViewHolder(binding.root) {

        init {
            binding.buttonRetry.setOnClickListener {
                retry.invoke()
            }
        }

      /**
       * bind and set the state of the views based on the [LoadState]
       * */
        fun bind(loadState: LoadState) {
            binding.apply {
                progressBar.isVisible = loadState is LoadState.Loading
                buttonRetry.isVisible = loadState !is LoadState.Loading
                textViewError.isVisible = loadState !is LoadState.Loading
            }
        }
    }
}