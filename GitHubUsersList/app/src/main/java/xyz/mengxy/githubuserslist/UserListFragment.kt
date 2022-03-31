package xyz.mengxy.githubuserslist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.paging.LoadState
import com.google.android.material.snackbar.Snackbar
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.ExperimentalCoroutinesApi
import xyz.mengxy.githubuserslist.adapter.UserAdapter
import xyz.mengxy.githubuserslist.databinding.FragmentUserListBinding
import xyz.mengxy.githubuserslist.model.User
import xyz.mengxy.githubuserslist.util.PAYLOAD_UPDATE_FOLLOW_STATE
import xyz.mengxy.githubuserslist.util.hideKeyboard
import xyz.mengxy.githubuserslist.viewmodel.UserDetailViewModel
import xyz.mengxy.githubuserslist.viewmodel.UserViewModel

/**
 * Created by Mengxy on 3/29/22.
 * user list fragment
 * check is binding inflated at onCreateView() because navigation use replace() to navigate
 * fragment, so this fragment recreated when come back
 * see [FragmentNavigator] navigate() function.
 */
@ExperimentalCoroutinesApi
@AndroidEntryPoint
class UserListFragment : Fragment() {

    private val userViewModel: UserViewModel by viewModels()
    private val detailViewModel: UserDetailViewModel by activityViewModels()
    private var adapter: UserAdapter? = null
    private var binding: FragmentUserListBinding? = null

    private val followActionObserver = Observer<User> { user ->
        val index = adapter?.snapshot()?.items?.indexOfLast { it.userId == user.userId } ?: -1
        if (index >= 0) {
            adapter?.run {
                notifyItemChanged(index, PAYLOAD_UPDATE_FOLLOW_STATE)
            }
        }
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
                    userViewModel.searchLiveData.observe(viewLifecycleOwner) {
                        submitData(lifecycle, it)
                    }
                }
                etSearch.setOnEditorActionListener { view, actionId, _ ->
                    if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                        val queryStr = binding?.etSearch?.text.toString().trim()
                        if (queryStr.isEmpty()) {
                            Snackbar.make(root, R.string.search_content_hint, Snackbar.LENGTH_LONG)
                                .show()
                        } else {
                            userViewModel.searchUsers(queryStr)
                        }
                        view.hideKeyboard()
                    }
                    true
                }
            }
            userViewModel.searchUsers()
        }
        detailViewModel.followUserLiveData.observe(viewLifecycleOwner, followActionObserver)
        return binding?.root
    }
}
