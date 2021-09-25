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
import com.yxf.githubuserlist.model.bean.UserDetail
import com.yxf.githubuserlist.repo.UserRepo
import com.yxf.mvvmcommon.ktx.catchOnCoroutine
import com.yxf.mvvmcommon.ktx.collectOnCoroutine
import com.yxf.mvvmcommon.mvvm.BaseViewModel
import com.yxf.mvvmcommon.utils.ToastUtils
import kotlinx.coroutines.flow.*
import org.koin.core.component.KoinComponent
import java.lang.ref.WeakReference
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashSet


class UserListViewModel(private var userRepo: UserRepo) : BaseViewModel(), KoinComponent {

    private val TAG = UserListViewModel::class.qualifiedName


    var pageCache = LruCache<Int, PageDetail>(5)
    var lastPageCache: LruCache<Int, PageDetail>? = null

    //value can not be null
    val userListData = MutableLiveData<MutableList<UserInfo>>().apply { value = ArrayList() }

    val loadMoreData = MutableLiveData<Boolean>()
    val loadRefreshData = MutableLiveData<Boolean>()

    val missingPageLoadedData = MutableLiveData<Boolean>()

    val selectedUserDetailData = MutableLiveData<UserDetail>()

    private val loadingPageSet = HashSet<Int>()

    private val missingPageSet = HashSet<Int>()


    private var currentSearchContent: String? = null
    private val searchStateFlow by lazy {
        MutableStateFlow("").also { flow ->
            flow.debounce(300)
                .mapLatest { return@mapLatest it }
                .collectOnCoroutine(viewModelScope) {
                    loadRefresh(it)
                }
        }
    }

    private var loadMorePage = -1


    fun loadPage(page: Int, searchContent: String = getSearchContent()) {
        val pageDetail = pageCache[page]
        if (pageDetail != null) {
            onPageLoadSuccessfully(page)
            return
        }
        if (loadingPageSet.contains(page)) {
            Log.d(TAG, "page: $page is in loading")
            return
        }
        loadingPageSet.add(page)
        toFlow { userRepo.getUserList(page, searchContent) }
            .filter { searchContent == getSearchContent() }
            .catchOnCoroutine(viewModelScope) {
                Log.e(TAG, "load page($page) failed", it)
                loadingPageSet.remove(page)
                onPageLoadFailed(page)
            }.collectOnCoroutine(viewModelScope) {
                pageCache.put(page, it)
                onPageLoadSuccessfully(page)
                loadingPageSet.remove(page)
            }
    }

    private fun onPageLoadSuccessfully(page: Int) {
        notifyLoadMoreFinished(page)
        notifyLoadRefreshFinished(page)
        notifyLoadMissingPageFinished(page)
        updateUserList(page)
    }

    private fun onPageLoadFailed(page: Int) {
        notifyLoadMoreFinished(page, false)
        notifyLoadRefreshFinished(page, false)
        notifyLoadMissingPageFinished(page, false)
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


    fun getUserDetail(info: UserInfo): UserDetail? {
        return info.detailReference?.get() ?: pageCache[info.page]?.userDetailList?.get(info.index)
    }


    //----------------------search----------------------

    fun onSearchContentChanged(content: String?) {
        searchStateFlow.value = content ?: ""
    }

    private fun getSearchContent(): String {
        return if (currentSearchContent.isNullOrEmpty()) "Android" else currentSearchContent!!
    }


    //----------------------load refresh-----------------

    fun loadRefresh(content: String? = null) {
        if (content != null && content != currentSearchContent) {
            clearPreviousContext()
            currentSearchContent = content
        }
        loadRefreshData.value = false
        lastPageCache = pageCache
        pageCache = LruCache<Int, PageDetail>(5)
        loadPage(0, getSearchContent())
    }

    private fun clearPreviousContext() {
        loadingPageSet.iterator().run {
            while (hasNext()) {
                onPageLoadFailed(next())
                remove()
            }
        }
        missingPageSet.clear()
    }

    private fun notifyLoadRefreshFinished(page: Int, result: Boolean = true) {
        if (page == 0 && loadRefreshData.value == false) {
            userListData.value = ArrayList()
            //clear unnecessary cache
            lastPageCache = null
            loadRefreshData.value = true
            if (!result) {
                ToastUtils.shortToast("update user list failed")
            }
        }
    }

    //----------------------load missing------------------

    public fun loadMissingPage(page: Int) {
        missingPageSet.add(page)
        loadPage(page)
    }

    private fun notifyLoadMissingPageFinished(page: Int, result: Boolean = true) {
        if (missingPageSet.contains(page)) {
            missingPageLoadedData.value = result
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

    private fun notifyLoadMoreFinished(page: Int, result: Boolean = true) {
        if (page == loadMorePage) {
            loadMoreData.value = true
            resetLoadMorePage()
            if (!result) {
                ToastUtils.shortToast("load more user information failed")
            }
        }
    }

    private fun resetLoadMorePage() {
        loadMorePage = -1
    }

    //-------------------------------------------------------

}