package com.wiredcraft.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.transition.TransitionInflater
import com.wiredcraft.R
import com.wiredcraft.adapter.ReposRecyclerViewAdapter
import com.wiredcraft.bean.FollowState
import com.wiredcraft.bean.UserItem
import com.wiredcraft.database.AppDatabase
import com.wiredcraft.databinding.FragmentReposBinding
import com.wiredcraft.decoration.VerticalDecoration
import com.wiredcraft.network.RetrofitUtil
import com.wiredcraft.service.GithubApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking

class ReposFragment : Fragment() {
    private lateinit var viewBinding: FragmentReposBinding
    private var adapter = ReposRecyclerViewAdapter()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedElementEnterTransition =
            TransitionInflater.from(requireContext()).inflateTransition(R.transition.shared_image)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewBinding = FragmentReposBinding.inflate(inflater)
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        arguments?.getParcelable<UserItem>("userItem")?.let {
            arguments
            viewBinding.name.text = it.login
            viewBinding.avatar.setImageURI(it.avatar_url)
            if (it.followState) {
                viewBinding.follow.setText(R.string.followed)
            } else {
                viewBinding.follow.setText(R.string.follow)
            }
            viewBinding.follow.setOnClickListener { _ ->
                it.followState = !it.followState
                if (it.followState) {
                    viewBinding.follow.setText(R.string.followed)
                } else {
                    viewBinding.follow.setText(R.string.follow)
                }
                runBlocking(Dispatchers.IO) {
                    AppDatabase.getInstance().userDao()
                        .insertOrUpdate(FollowState(it.id, it.followState))
                    SearchUserFragment.followObserver.postValue(it)
                }
            }
            lifecycleScope.launch {
                try {
                    val data = RetrofitUtil.create(GithubApi::class.java).userRepos(it.login)
                    adapter.dataSource.addAll(data)
                    viewBinding.recyclerView.addItemDecoration(VerticalDecoration())
                    viewBinding.recyclerView.adapter = adapter
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }
}