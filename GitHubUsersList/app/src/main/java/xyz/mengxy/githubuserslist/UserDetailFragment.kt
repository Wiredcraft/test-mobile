package xyz.mengxy.githubuserslist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import androidx.paging.LoadState
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import xyz.mengxy.githubuserslist.adapter.RepoAdapter
import xyz.mengxy.githubuserslist.databinding.FragmentUserDetailBinding
import xyz.mengxy.githubuserslist.model.User
import xyz.mengxy.githubuserslist.viewmodel.RepoViewModel
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel

/**
 * Created by Mengxy on 3/29/22.
 * user detail page
 */
@AndroidEntryPoint
class UserDetailFragment : Fragment() {

    private val repoViewModel: RepoViewModel by viewModels()
    private val detailViewModel: UserDetailViewModel by activityViewModels()
    private val adapter = RepoAdapter()
    private var repoJob: Job? = null
    private var binding: FragmentUserDetailBinding? = null

    // follow observer when click FOLLOW/UNFOLLOW button
    private val followActionObserver = Observer<User> { user ->
        binding?.apply {
            tvFollowButton.text = resources.getString(
                if (user.isFollowed) {
                    R.string.text_followed
                } else {
                    R.string.text_follow
                }
            )
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentUserDetailBinding.inflate(inflater, container, false)
        binding?.apply {
            setFollowListener {
                detailViewModel.userLiveData.value?.let {
                    detailViewModel.followUser(it)
                }
            }
            srlSwipeRefresh.setOnRefreshListener {
                adapter.refresh()
            }
            val userInfo = detailViewModel.userLiveData.value
            user = userInfo
            rvRepoList.adapter = adapter.apply {
                addLoadStateListener {
                    srlSwipeRefresh.isRefreshing = it.refresh is LoadState.Loading
                }
            }
            userInfo?.userName?.let {
                getRepoList(it)
            }
        }
        detailViewModel.followUserLiveData.observe(viewLifecycleOwner, followActionObserver)
        return binding?.root
    }

    // get repo list
    private fun getRepoList(userName: String) {
        // cancel the previous job before creating a new one
        repoJob?.cancel()
        repoJob = lifecycleScope.launch {
            repoViewModel.getUserRepos(userName).collectLatest {
                adapter.submitData(it)
            }
        }
    }
}
