package com.yxf.githubuserlist.module.userlist

import android.util.Log
import android.util.LruCache
import androidx.annotation.MainThread
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.yxf.githubuserlist.ktx.getLastPage
import com.yxf.githubuserlist.ktx.requireValue
import com.yxf.githubuserlist.model.UserInfo
import com.yxf.githubuserlist.model.bean.PageDetail
import com.yxf.githubuserlist.repo.UserRepo
import com.yxf.mvvmcommon.mvvm.BaseViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import java.lang.ref.WeakReference
import java.util.*
import kotlin.collections.ArrayList


class UserListViewModel(private var userRepo: UserRepo) : BaseViewModel(), KoinComponent {

    private val TAG = UserListViewModel::class.qualifiedName


    val pageCache = LruCache<Int, PageDetail>(5)

    //value can not be null
    val userListData = MutableLiveData<MutableList<UserInfo>>().apply { value = ArrayList() }

    val loadMoreData = MutableLiveData<Boolean>()
    val loadRefreshData = MutableLiveData<Boolean>()

    private val loadingPageSet = Collections.synchronizedSet(HashSet<Int>())

    private var loadMorePage = -1


    fun loadPage(index: Int) {
        val pageDetail = pageCache[index]
        if (pageDetail != null) {
            onPageLoadSuccessfully(index)
            return
        }
        if (loadingPageSet.contains(index)) {
            Log.d(TAG, "page: $index is in loading")
            return
        }
        loadingPageSet.add(index)
        viewModelScope.launch(Dispatchers.Main) {
            toFlow { return@toFlow userRepo.getUserList(index) }
                .catch {
                    Log.e(TAG, "load page($index) failed", it)
                    loadingPageSet.remove(index)
                    onPageLoadFailed(index)
                }.collect {
                    pageCache.put(index, it)
                    onPageLoadSuccessfully(index)
                    loadingPageSet.remove(index)
                }
        }
    }

    private fun onPageLoadSuccessfully(page: Int) {
        notifyLoadMoreFinished(page)
        notifyLoadRefreshFinished(page)
        updateUserList(page)
    }

    private fun onPageLoadFailed(page: Int) {
        notifyLoadMoreFinished(page)
        notifyLoadRefreshFinished(page, false)
    }


    @MainThread
    private fun updateUserList(page: Int) {
        if (page != userListData.getLastPage() + 1) {
            return
        }
        val pageDetail = pageCache[page]
        val userDetailList = pageDetail.userDetailList
        val userList = userListData.requireValue()
        for ((i, v) in userDetailList.withIndex()) {
            val info = UserInfo(page, i)
            info.detailReference = WeakReference(v)
            userList.add(info)
        }
        userListData.value = userList
    }

    //----------------------load refresh-----------------

    fun loadRefresh() {
        loadRefreshData.value = false
        pageCache.evictAll()
        loadRefreshUserList()
    }

    private fun loadRefreshUserList() {
        loadPage(0)
    }

    private fun notifyLoadRefreshFinished(page: Int, successfully: Boolean = true) {
        if (page == 0 && loadRefreshData.value == false) {
            if (successfully) {
                userListData.value = ArrayList()
            }
            loadRefreshData.value = true
        }
    }

    //----------------------load more---------------------

    fun loadMore() {
        loadMoreData.value = false
        loadMoreUserList()
    }

    private fun loadMoreUserList() {
        loadMorePage = userListData.getLastPage() + 1
        loadPage(loadMorePage)
    }

    private fun notifyLoadMoreFinished(page: Int) {
        if (page == loadMorePage) {
            loadMoreData.value = true
            resetLoadMorePage()
        }
    }

    private fun resetLoadMorePage() {
        loadMorePage = -1
    }

    //-------------------------------------------------------

}