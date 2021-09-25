package com.yxf.githubuserlist.module.userlist

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.yxf.githubuserlist.R
import com.yxf.githubuserlist.databinding.FragmentUserListBinding
import com.yxf.githubuserlist.model.UserInfo
import com.yxf.githubuserlist.model.bean.PageDetail
import com.yxf.mvvmcommon.mvvm.BaseVMFragment
import com.yxf.mvvmcommon.utils.ToastUtils

class UserListFragment : BaseVMFragment<UserListViewModel, FragmentUserListBinding>(),
    SearchView.OnQueryTextListener, PageLoader {

    private val TAG = UserListFragment::class.qualifiedName

    private var rvAdapter: UserListAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initObserver()
        initActionBar()
        initRecyclerView()
        initSmartRefreshLayout()
        vm.loadRefresh()
    }

    private fun initObserver() {
        vm.userListData.observe(viewLifecycleOwner, {
            onUserListChanged(it)
        })
        vm.loadMoreData.observe(viewLifecycleOwner, {
            if (it) vb.smartRefreshLayout.finishLoadMore()
        })
        vm.loadRefreshData.observe(viewLifecycleOwner, {
            if (it) {
                vb.smartRefreshLayout.run {
                    finishRefresh()
                    resetNoMoreData()
                }
            }
        })
        vm.missingPageLoadedData.observe(viewLifecycleOwner, {
            if (it) {
                rvAdapter?.notifyDataSetChanged()
            } else {
                Log.w(TAG, "load missing page failed")
            }
        })
    }

    private fun initActionBar() {
        val activity = requireActivity() as AppCompatActivity
        activity.setSupportActionBar(vb.toolbar)
    }


    private fun initSmartRefreshLayout() {
        vb.smartRefreshLayout.run {
            setEnableLoadMore(true)
            setOnRefreshListener {
                refreshUserList()
            }
            setOnLoadMoreListener {
                vm.loadMore()
            }
        }
    }

    private fun initRecyclerView() {
        vb.userListRecyclerView.run {
            itemAnimator = DefaultItemAnimator()
            layoutManager = LinearLayoutManager(context)
            addItemDecoration(DividerItemDecoration(context, DividerItemDecoration.VERTICAL))
            adapter = UserListAdapter(vm.userListData.value!!, this@UserListFragment).also {
                it.onItemClickListener = object : OnItemClickListener {
                    override fun onItemClick(itemView: View, info: UserInfo, position: Int) {
                        vm.selectedUserDetailData.value = vm.getUserDetail(info)
                    }
                }
                rvAdapter = it
            }
        }
    }

    private fun refreshUserList() {
        vm.loadRefresh()
    }

    private fun onUserListChanged(userList: MutableList<UserInfo>) {
        rvAdapter?.updateList(userList)
    }


    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.menu_search, menu)
        val searchItem = menu.findItem(R.id.action_search)
        val searchView = searchItem.actionView as SearchView
        initSearchView(searchView)
    }

    @SuppressLint("ResourceType")
    private fun initSearchView(searchView: SearchView) {
        searchView.setOnQueryTextListener(this)
        val iconColor = resources.getColor(R.color.toolbar_icon_color)
        setImageViewColor(androidx.appcompat.R.id.search_button, iconColor, searchView)
        setImageViewColor(androidx.appcompat.R.id.search_go_btn, iconColor, searchView)
        setImageViewColor(androidx.appcompat.R.id.search_close_btn, iconColor, searchView)
        setImageViewColor(androidx.appcompat.R.id.search_mag_icon, iconColor, searchView)
        searchView.findViewById<TextView>(androidx.appcompat.R.id.search_src_text)
            .setTextColor(iconColor)
    }

    private fun setImageViewColor(id: Int, color: Int, parent: ViewGroup) {
        val iconView = parent.findViewById<ImageView>(id)
        iconView.setColorFilter(color, android.graphics.PorterDuff.Mode.SRC_IN)
    }

    override fun onQueryTextSubmit(query: String?): Boolean {
        return false
    }

    override fun onQueryTextChange(newText: String?): Boolean {
        vm.onSearchContentChanged(newText)
        return true
    }

    override fun loadMissingPage(page: Int) {
        vm.loadMissingPage(page)
    }

    override fun getPage(page: Int): PageDetail? {
        return vm.pageCache[page]
    }


}