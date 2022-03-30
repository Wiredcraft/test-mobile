package xyz.mengxy.githubuserslist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.paging.LoadState
import com.google.android.material.snackbar.Snackbar
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import xyz.mengxy.githubuserslist.adapter.UserAdapter
import xyz.mengxy.githubuserslist.databinding.FragmentUserListBinding
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel
import xyz.mengxy.githubuserslist.viewmodel.UserViewModel

/**
 * Created by Mengxy on 3/29/22.
 * user list fragment
 * check is binding inflated at onCreateView() because navigation use replace() to navigate
 * fragment, so this fragment recreated when come back
 * see [FragmentNavigator] navigate() function.
 */
@AndroidEntryPoint
class UserListFragment : Fragment() {

    private val userViewModel: UserViewModel by viewModels()
    private val detailViewModel: UserDetailViewModel by activityViewModels()
    private var adapter: UserAdapter? = null
    private var searchJob: Job? = null
    private var binding: FragmentUserListBinding? = null

    companion object {
        const val DEFAULT_SEARCH = "kotlin"
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        if (binding == null) {
            adapter = UserAdapter(detailViewModel)
            binding = FragmentUserListBinding.inflate(inflater, container, false).apply {
                srlSwipeRefresh.setOnRefreshListener {
                    adapter?.refresh()
                }
                rvUserList.adapter = adapter?.apply {
                    addLoadStateListener {
                        srlSwipeRefresh.isRefreshing = it.refresh is LoadState.Loading
                    }
                }
                etSearch.setOnEditorActionListener { view, actionId, _ ->
                    if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                        val queryStr = binding?.etSearch?.text.toString().trim()
                        if (queryStr.isEmpty()) {
                            Snackbar.make(root, R.string.search_content_hint, Snackbar.LENGTH_LONG).show()
                        } else {
                            searchUser(queryStr)
                        }
                        view.hideKeyboard()
                    }
                    true
                }
            }
            searchUser()
        }
        return binding?.root
    }

    private fun searchUser(query: String = DEFAULT_SEARCH) {
        searchJob?.cancel()
        searchJob = lifecycleScope.launch {
            userViewModel.searchUsers(query).collectLatest {
                adapter?.submitData(it)
            }
        }
    }
}
