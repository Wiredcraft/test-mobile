package com.example.testmobile

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.testmobile.model.GithubUser

@BindingAdapter("userList")
fun setUserList(recyclerView: RecyclerView, events: List<GithubUser>?) {
    (recyclerView.adapter as GithubUserAdapter).submitList(events)
}