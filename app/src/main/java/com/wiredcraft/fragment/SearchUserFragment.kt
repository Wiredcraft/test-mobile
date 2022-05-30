package com.wiredcraft.fragment

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.core.content.getSystemService
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.lifecycleScope
import com.wiredcraft.adapter.SearchUserRecyclerViewAdapter
import com.wiredcraft.bean.SearchUser
import com.wiredcraft.bean.UserItem
import com.wiredcraft.database.AppDatabase
import com.wiredcraft.databinding.FragmentSearchUserBinding
import com.wiredcraft.decoration.VerticalDecoration
import com.wiredcraft.network.RetrofitUtil
import com.wiredcraft.service.GithubApi
import com.wiredcraft.viewmodel.SearchUserViewModel
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class SearchUserFragment : DialogFragment() {
    companion object {
        val followObserver = MutableLiveData<UserItem>()
    }

    private val viewBinding: FragmentSearchUserBinding by lazy {
        FragmentSearchUserBinding.inflate(layoutInflater)
    }
    private val githubAPI = RetrofitUtil.create(GithubApi::class.java)
    private var job: Job? = null
    private var adapter = SearchUserRecyclerViewAdapter(SearchUser())
    private val searchUserViewModel: SearchUserViewModel by viewModels()

    private val textWatcher = object : TextWatcher {
        override fun afterTextChanged(s: Editable) {}
        override fun beforeTextChanged(text: CharSequence, start: Int, count: Int, after: Int) {}
        override fun onTextChanged(text: CharSequence, start: Int, before: Int, count: Int) {
            refresh(text.toString(), timeMillis = 1000)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return viewBinding.root //navigation replace fragment 这里保存了视图
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        if (searchUserViewModel.isFirst) {
            viewBinding.recyclerView.addItemDecoration(VerticalDecoration())
            viewBinding.searchEditText.setOnEditorActionListener { _, _, _ ->
                context?.getSystemService<InputMethodManager>()?.hideSoftInputFromWindow(
                    activity?.currentFocus?.windowToken, InputMethodManager.HIDE_NOT_ALWAYS
                )
                refresh(viewBinding.searchEditText.text!!.toString())
                true
            }
            viewBinding.smartRefreshLayout.setOnRefreshListener {
                refresh(viewBinding.searchEditText.text!!.toString())
            }
            viewBinding.smartRefreshLayout.setOnLoadMoreListener {
                loadMore()
            }
            viewBinding.searchEditText.addTextChangedListener(textWatcher)
            searchUserViewModel.isFirst = false
            refresh(searchUserViewModel.defKeyword)
        } else {
            viewBinding.searchEditText.removeTextChangedListener(textWatcher)
            viewBinding.searchEditText.setText(searchUserViewModel.query)
            viewBinding.searchEditText.addTextChangedListener(textWatcher)
            adapter = viewBinding.recyclerView.adapter as SearchUserRecyclerViewAdapter
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        followObserver.observe(this) {
            adapter.notifyItemChanged(adapter.dataSource.items.indexOf(it))
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        followObserver.removeObservers(this)
    }

    private fun loadMore() {
        lifecycleScope.launch {
            job?.cancel()
            job = launch {
                try {
                    val query = viewBinding.searchEditText.text!!.toString()
                    searchUserViewModel.query = query
                    val result = githubAPI.searchUser(
                        query = query.ifEmpty { searchUserViewModel.defKeyword },
                        page = ++searchUserViewModel.page
                    ).apply {
                        val map = AppDatabase.getInstance().userDao().getAll()
                            .associate { it.id to it.state }
                        items.forEach {
                            it.followState = map[it.id] ?: false
                        }
                    }
                    val start = adapter.itemCount
                    searchUserViewModel.searchUser.items.addAll(result.items)
                    adapter.dataSource = searchUserViewModel.searchUser
                    viewBinding.recyclerView.adapter?.notifyItemRangeInserted(
                        start,
                        adapter.itemCount
                    )
                } catch (e: Exception) {
                    e.printStackTrace()
                    --searchUserViewModel.page
                }
                viewBinding.smartRefreshLayout.finishLoadMore()
            }
        }
    }

    private fun refresh(
        text: String,
        timeMillis: Long = 0
    ) {
        lifecycleScope.launch {
            job?.cancel()
            job = launch {
                delay(timeMillis)
                searchUserViewModel.page = 1
                searchUserViewModel.query = if (searchUserViewModel.defKeyword != text) text else ""
                searchUserViewModel.scrollY = 0
                searchUserViewModel.searchUser = try {
                    githubAPI.searchUser(
                        text.ifEmpty { searchUserViewModel.defKeyword },
                        searchUserViewModel.page
                    ).apply {
                        val map = AppDatabase.getInstance().userDao().getAll()
                            .associate { it.id to it.state }
                        items.forEach {
                            it.followState = map[it.id] ?: false
                        }
                    }
                } catch (e: Exception) {
                    SearchUser()
                }
                adapter = SearchUserRecyclerViewAdapter(searchUserViewModel.searchUser)
                viewBinding.smartRefreshLayout.finishRefresh()
                viewBinding.recyclerView.adapter = adapter
                viewBinding.recyclerView.scheduleLayoutAnimation()
            }
        }
    }
}
