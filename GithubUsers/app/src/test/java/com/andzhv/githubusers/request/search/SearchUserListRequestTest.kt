package com.andzhv.githubusers.request.search

import com.andzhv.githubusers.Config
import com.andzhv.githubusers.RxJavaRule
import com.andzhv.githubusers.bean.BaseSearchResponse
import com.andzhv.githubusers.bean.SimpleUserBean
import com.andzhv.githubusers.utils.ex.just
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.functions.Consumer
import io.reactivex.rxjava3.observers.TestObserver
import org.junit.Assert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.Mockito
import org.mockito.kotlin.any
import org.mockito.kotlin.whenever
import org.powermock.reflect.Whitebox
import kotlin.math.max

/**
 * Created by zhaowei on 2021/9/13.
 */
class SearchUserListRequestTest {
    @Rule
    @JvmField
    val rule = RxJavaRule()

    @Before
    fun setUp() {
    }

    /**
     * If I get an error when requesting data, the page remains unchanged until the requested data is complete
     */
    @Test
    fun failure() {
        val responseList: List<SearchUserResponse> = listOf(
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
            SearchUserResponse.Failure,
            SearchUserResponse.Failure,
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
            SearchUserResponse.Failure,
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
        )
        val request = Mockito.spy(SearchUserListRequest("Android"))
        mockRequest(request, responseList.toMutableList())

        checkRxResult(request, 1, 0, Config.LIST_LIMIT) {}
        checkRxComplete(request, 2)
        checkRxComplete(request, 2)
        checkRxResult(request, 2, 0, Config.LIST_LIMIT) {}
        checkRxComplete(request, 3)
        checkRxResult(request, 3, 0, Config.LIST_LIMIT) {}
    }

    /**
     * If the data returned by the api is incomplete for three consecutive times,
     * I will throw an error and the page remains unchanged until the requested data is complete
     */
    @Test
    fun in_complete_compare_multiple() {
        val responseList: List<SearchUserResponse> = listOf(
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
            SearchUserResponse.Success(true, 6),
            SearchUserResponse.Success(true, 8),
            SearchUserResponse.Success(true, 9),
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
        )
        val request = Mockito.spy(SearchUserListRequest("Android"))
        mockRequest(request, responseList.toMutableList())
        checkRxResult(request, 1, 0, Config.LIST_LIMIT) { }
        checkRxResult(request, 2, 0, max(6, 8)) { }
        checkRxComplete(request, 2)
        checkRxResult(request, 2, max(6, 8), Config.LIST_LIMIT) {}
        Assert.assertEquals(getCurrentPage(request), 3)
    }

    /**
     * Send 4 requests, the data of two request is incomplete, but the result is same
     */
    @Test
    fun in_complete_compare() {
        Assert.assertEquals(in_complete(2, 11), in_complete(3, 4))
    }

    /**
     * When the result is incomplete, the request will be repeated once, and the most one will be embittered.
     * When user pull up to load more data, the page remains unchanged until complete data is obtained
     */
    @Test
    fun in_complete_first() {
        in_complete(5, 3)
    }

    /**
     * When the result is incomplete, the request will be repeated once, and the most one will be embittered.
     * When user pull up to load more data, the page remains unchanged until complete data is obtained
     */
    @Test
    fun in_complete_second() {
        in_complete(3, 5)
    }

    /**
     * @param first The number of users returned by the server when the data is incomplete for the first time
     * @param second The number of users returned by the server when the data is incomplete for the first time
     */
    private fun in_complete(first: Int, second: Int): List<SimpleUserBean> {

        val result = mutableListOf<SimpleUserBean>()

        val responseList: List<SearchUserResponse> = listOf(
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
            SearchUserResponse.Success(true, first),
            SearchUserResponse.Success(true, second),
            SearchUserResponse.Success(false, Config.LIST_LIMIT),
        )

        val request = Mockito.spy(SearchUserListRequest("Android"))
        mockRequest(request, responseList.toMutableList())


        checkRxResult(request, 1, 0, Config.LIST_LIMIT) { result.addAll(it) }
        checkRxResult(request, 2, 0, max(first, second)) { result.addAll(it) }

        checkRxResult(request, 2, max(first, second), Config.LIST_LIMIT) { result.addAll(it) }

        Assert.assertEquals(getCurrentPage(request), 3)
        return result
    }

    /**
     * Check the data of each request
     * @param request Current request
     * @param page Current page number
     * @param fromIndex result.subList(fromIndex, result.size)
     */
    private fun checkRxResult(
        request: SearchUserListRequest,
        page: Int,
        fromIndex: Int,
        size: Int,
        onNext: Consumer<List<SimpleUserBean>>,
    ) {
        val currentPage = getCurrentPage(request)
        Assert.assertEquals(currentPage, page)
        val result = TestObserver<List<SimpleUserBean>>()
        request.request().doOnNext(onNext).subscribe(result)
        val list = generate(currentPage, Config.LIST_LIMIT, size)
        result.assertResult(list.subList(fromIndex, list.size))
    }

    /**
     * When the request returns an error
     */
    private fun checkRxComplete(request: SearchUserListRequest, page: Int) {
        val currentPage = getCurrentPage(request)
        Assert.assertEquals(currentPage, page)
        val result = TestObserver<List<SimpleUserBean>>()
        request.request().subscribe(result)
        result.assertComplete()
    }

    /**
     * Get the page of the request
     */
    private fun getCurrentPage(request: SearchUserListRequest): Int {
        return Whitebox.getInternalState(request, "pageFlag")
    }

    /**
     * Mock list
     * @param page
     * @param perPage
     * @param size How much data is needed, mock the incomplete data
     */
    private fun generate(page: Int, perPage: Int, size: Int): List<SimpleUserBean> {
        return (0 until perPage).filterIndexed { index, _ -> index < size }.map {
            val id = (page - 1) * perPage + it
            SimpleUserBean(id.toLong(), "$id", "", 1f, "", "")
        }
    }

    private fun mockRequest(request: SearchUserListRequest, list: MutableList<SearchUserResponse>) {
        request.refresh()
        whenever(request.searchRequest(any(), any())).thenAnswer {
            val page = it.getArgument<Int>(0)
            val perPage = it.getArgument<Int>(1)
            when (val first = list.firstOrNull()) {
                is SearchUserResponse.Success -> {
                    list.removeAt(0)
                    BaseSearchResponse(
                        1000,
                        first.inCompleted,
                        generate(page, perPage, first.size)
                    ).just()
                }
                is SearchUserResponse.Failure -> {
                    list.removeAt(0)
                    Observable.error(Throwable("Failure"))
                }
                else -> Observable.error(Throwable("No more data"))
            }
        }
    }
}