package com.example.testmobile

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.testmobile.databinding.ActivityMainBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private val homeViewModel: HomeViewModel by viewModels()
    private lateinit var viewDataBinding: ActivityMainBinding
    private var githubUserAdapter: GithubUserAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewDataBinding = ActivityMainBinding.inflate(layoutInflater, null, false).apply {
            viewModel = homeViewModel
        }
        viewDataBinding.lifecycleOwner = this
        setContentView(viewDataBinding.root)

        githubUserAdapter = GithubUserAdapter(this) { user ->
            user?.let {
                val intent = Intent(this, WebViewActivity::class.java)
                intent.putExtra("user", it)
                startActivity(intent)
            }
        }
        viewDataBinding.rv.adapter = githubUserAdapter

        initRefreshAndLoadMore()
        initSearchListener()
        setViewModelObserver()

        // Init data
        homeViewModel.initHomePageData()
    }

    private fun setViewModelObserver() {
        // Stop refresh UI
        homeViewModel.refreshLoading.observe(this, Observer {
            viewDataBinding.swipeRefreshLayout.isRefreshing = it
        })
        // Show refresh user list
        homeViewModel.refreshUsers.observe(this, Observer {
            if (it != null) {
                homeViewModel.refreshUsers.value = null
                githubUserAdapter?.refreshData(it)
            }
        })
        // Append load more user list
        homeViewModel.appendUsers.observe(this, Observer {
            if (it != null) {
                homeViewModel.appendUsers.value = null
                githubUserAdapter?.appendData(it)
            }
        })
    }

    /**
     * Init refresh and load more listener
     */
    private fun initRefreshAndLoadMore() {
        viewDataBinding.swipeRefreshLayout.setColorSchemeResources(R.color.black)
        // Refresh listener
        viewDataBinding.swipeRefreshLayout.setOnRefreshListener {
            homeViewModel.initHomePageData()
        }
        val llm = viewDataBinding.rv.layoutManager as LinearLayoutManager

        // Load more listener
        viewDataBinding.rv.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)
                githubUserAdapter?.let {
                    if (llm.findLastCompletelyVisibleItemPosition() == it.itemCount - 1) {
                        homeViewModel.loadMore()
                    }
                }
            }

            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                super.onScrollStateChanged(recyclerView, newState)
                // Hide keyboard
                viewDataBinding.etSearch.hideKeyboard()
            }
        })
    }

    /**
     * Add search listener
     */
    private fun initSearchListener() {
        // Monitor search text change
        homeViewModel.searchText.observe(this, Observer {
            homeViewModel.initHomePageData()
        })
    }

}