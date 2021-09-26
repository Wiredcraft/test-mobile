package com.testmobile.githubuserslist

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.core.view.isVisible
import androidx.paging.LoadState
import androidx.recyclerview.widget.RecyclerView
import com.testmobile.githubuserslist.adapter.UserLoadStateAdapter
import com.testmobile.githubuserslist.adapter.UsersAdapter
import com.testmobile.githubuserslist.databinding.ActivityMainBinding
import com.testmobile.githubuserslist.viewmodel.UserViewModel
import dagger.hilt.android.AndroidEntryPoint

/**
 * @AndroidEntryPoint annotation lets this class gets an instance to the
 * [UserViewModel classs]
 * */
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    // instance of the userview model
    private val viewModel by viewModels<UserViewModel>()

    /**
     * lateinit [ActivityMainBinding] class and promise the kotlin compiler
     * the value will ne initialised before using its
     * */
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // instance of user adapter class
        val adapter = UsersAdapter()
        //bind the views
        binding.apply {
            recyclerView.setHasFixedSize(true)
            recyclerView.itemAnimator = null
            //add a load state footer to the recyclerview
            recyclerView.adapter = adapter.withLoadStateFooter(
                footer = UserLoadStateAdapter { adapter.retry() }
            )
            recyclerView.itemAnimator?.changeDuration = 0
            activityMainButtonRetry.setOnClickListener { adapter.retry() }
        }

        // restore the state for the adatper
        adapter.stateRestorationPolicy =
            RecyclerView.Adapter.StateRestorationPolicy.PREVENT_WHEN_EMPTY

        binding.apply {
            swipeRefreshLayout.setOnRefreshListener {
                swipeRefreshLayout.isRefreshing = false;
                adapter.refresh()
            }
        }

        // observer the data returned by the viewmodel
        viewModel.users.observe(this) {
            adapter.submitData(this.lifecycle, it)
        }

        /** bind and set the visibility of the [LoadState] view items**/
        adapter.addLoadStateListener { loadState ->
            binding.apply {
                activityMainProgressBar.isVisible = loadState.source.refresh is LoadState.Loading
                recyclerView.isVisible = loadState.source.refresh is LoadState.NotLoading
                activityMainButtonRetry.isVisible = loadState.source.refresh is LoadState.Error
                activityMainTextViewError.isVisible = loadState.source.refresh is LoadState.Error

                // display empty textview when items are less than 1
                if (loadState.source.refresh is LoadState.NotLoading &&
                    loadState.append.endOfPaginationReached &&
                    adapter.itemCount < 1
                ) {
                    recyclerView.isVisible = false
                    activityMainTextViewEmpty.isVisible = true
                } else {
                    activityMainTextViewEmpty.isVisible = false
                }
            }
        }
    }
}