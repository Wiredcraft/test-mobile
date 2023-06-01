package com.aric.finalweather

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.aric.finalweather.adapter.RepoListAdapter
import com.aric.finalweather.databinding.FragmentProfileBinding


class ProfileFragment : Fragment() {
    private lateinit var viewModel: GithubViewModel
    private lateinit var binding: FragmentProfileBinding
    private lateinit var repoListAdapter: RepoListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = ViewModelProvider(requireActivity())[GithubViewModel::class.java]
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate<FragmentProfileBinding?>(
            inflater,
            R.layout.fragment_profile,
            container,
            false
        ).also { it.lifecycleOwner = this@ProfileFragment }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.getRepos()

        repoListAdapter = RepoListAdapter()

        with(binding) {
            userInfo = viewModel.selectedUser.value
            repoList.adapter = repoListAdapter
            subscribe.setOnClickListener {
                viewModel.updateSelectedFollowingStatus()
            }
        }
        with(viewModel){
            repoList.observe(viewLifecycleOwner) {
                repoListAdapter.submitList(it)
            }
            selectedUser.observe(viewLifecycleOwner){
                binding.userInfo = it
            }
        }
    }
}