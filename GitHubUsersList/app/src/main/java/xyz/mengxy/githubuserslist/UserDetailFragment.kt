package xyz.mengxy.githubuserslist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.paging.LoadState
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import xyz.mengxy.githubuserslist.adapter.RepoAdapter
import xyz.mengxy.githubuserslist.databinding.FragmentUserDetailBinding
import xyz.mengxy.githubuserslist.viewmodel.RepoViewModel
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel

/**
 * Created by Mengxy on 3/29/22.
 */
@AndroidEntryPoint
class UserDetailFragment : Fragment() {

    private val repoViewModel: RepoViewModel by viewModels()
    private val detailViewModel: UserDetailViewModel by activityViewModels()
    private val adapter = RepoAdapter()
    private var repoJob: Job? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val binding = FragmentUserDetailBinding.inflate(inflater, container, false)
        binding.setFollowListener {
            //todo follow click
        }
        binding.srlSwipeRefresh.setOnRefreshListener {
            adapter.refresh()
        }
        val userInfo = detailViewModel.userLiveData.value
        binding.user = userInfo
        binding.rvRepoList.adapter = adapter.apply {
            addLoadStateListener {
                binding.srlSwipeRefresh.isRefreshing = it.refresh is LoadState.Loading
            }
        }
        userInfo?.userName?.let {
            getRepoList(it)
        }
        return binding.root
    }

    private fun getRepoList(userName: String) {
        repoJob?.cancel()
        repoJob = lifecycleScope.launch {
            repoViewModel.getUserRepos(userName).collectLatest {
                adapter.submitData(it)
            }
        }
    }
}
