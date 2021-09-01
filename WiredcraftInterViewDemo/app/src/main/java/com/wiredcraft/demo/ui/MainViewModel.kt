package com.wiredcraft.demo.ui

import android.content.Context
import android.content.Intent
import com.wiredcraft.demo.base.BasePagingViewModel
import com.wiredcraft.demo.network.subscribeOnCreate
import com.wiredcraft.demo.network.withLoading
import com.wiredcraft.demo.repository.UserRepositoryService
import com.wiredcraft.demo.repository.model.UserListDto
import com.wiredcraft.demo.ui.detail.UserDetailActivity
import com.wiredcraft.demo.ui.detail.UserDetailViewModel.Companion.PAGE_DATA
import dagger.hilt.android.qualifiers.ActivityContext
import io.reactivex.subjects.PublishSubject
import java.util.concurrent.TimeUnit
import javax.inject.Inject

class MainViewModel @Inject constructor(
    @ActivityContext val context: Context,
    private val userRepoService: UserRepositoryService
) : BasePagingViewModel() {

    val adapter = UserListAdapter(this)

    private var keywords = DEFAULT_SEARCH_WORDS
    private val queryPublisher = PublishSubject.create<String>()

    companion object {
        private const val TIME_OUT = 500L
        private const val DEFAULT_SEARCH_WORDS = "Java"
    }

    override fun onCreate() {
        super.onCreate()
        fetchData()

        queryPublisher.distinctUntilChanged()
            .debounce(TIME_OUT, TimeUnit.MILLISECONDS)
            .switchMapDelayError {
                pageNum = 1
                userRepoService.fetchUserList(pageNum, it)
            }
            .handlePagingResult()
            .subscribeOnCreate(this, {
                adapter.setData(it, pageNum == 1)
            })
    }

    override fun fetchData() {
        isRefreshing.set(true)
        userRepoService.fetchUserList(pageNum, keywords)
            .handlePagingResult()
            .withLoading(adapter.itemCount == 0) // not implement
            .subscribeOnCreate(this, {
                adapter.setData(it, pageNum == 1)
            })
    }

    fun onItemClick(dto: UserListDto) {
        // TODO: need optimize
        context.startActivity(Intent(context, UserDetailActivity::class.java).apply {
            putExtra(PAGE_DATA, dto.html_url)
        })
    }

    fun onEditTextChanged(text: String?) {
        keywords = if (text.isNullOrEmpty()) DEFAULT_SEARCH_WORDS else text
        queryPublisher.onNext(keywords)
    }
}