package com.aric.finalweather

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.aric.finalweather.adapter.UserListAdapter
import com.aric.finalweather.databinding.FragmentMainBinding
import com.aric.finalweather.extentions.hideKeyboard
import com.aric.finalweather.extentions.navigateTo


class MainFragment : Fragment() {
    private lateinit var vm: GithubViewModel
    private lateinit var userListAdapter: UserListAdapter
    private lateinit var binding: FragmentMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        vm = ViewModelProvider(requireActivity())[GithubViewModel::class.java]
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate<FragmentMainBinding?>(
            inflater,
            R.layout.fragment_main,
            container,
            false
        ).also { it.lifecycleOwner = this@MainFragment }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        userListAdapter = UserListAdapter ({
            vm.updateSelectedUser(it)
            vm.getRepos()
            navigateTo(R.id.action_main_to_profile, R.id.nav_host_fragment)
        },{
            vm.updateFollowingStatus(it)
        })

        with(binding) {
            userList.adapter = userListAdapter
            viewModel = vm

            swipeRefresh.setOnRefreshListener {
                vm.onSearch()
            }

            userList.addOnScrollListener(object : androidx.recyclerview.widget.RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: androidx.recyclerview.widget.RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    val layoutManager = recyclerView.layoutManager as androidx.recyclerview.widget.LinearLayoutManager
                    if (layoutManager.findLastVisibleItemPosition() == layoutManager.itemCount - 5) {
                        vm.loadMoreData()
                    }
                }
            })

        }

        with(vm) {
            onSearch()
            searchResult.observe(viewLifecycleOwner) {
                binding.swipeRefresh.isRefreshing = false
                userListAdapter.submitList(it)
                binding.userList.scrollToPosition(0)
                hideKeyboard()
            }
        }
    }
}