package com.andzhv.githubusers.ui.base

import BaseListActivity
import com.adgvcxz.IEvent
import com.adgvcxz.IModel
import com.adgvcxz.IMutation
import com.adgvcxz.recyclerviewmodel.RecyclerItemViewModel
import com.andzhv.githubusers.request.base.BaseListRequest
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
abstract class BaseRequestListActivity<T : Any> : BaseListActivity<BaseRequestListViewModel<T>>() {

    override val viewModel by lazy { InnerRecyclerViewModel() }

    abstract fun generateRequest(): BaseListRequest<T>

    abstract fun transform(position: Int, model: T): Observable<RecyclerItemViewModel<out IModel>>

    open fun header(cache: Boolean): Observable<RecyclerItemViewModel<out IModel>> {
        return Observable.empty()
    }

    open fun transformEvent(): Observable<IEvent> {
        return Observable.empty()
    }

    open fun transformMutation(): Observable<IMutation> {
        return Observable.empty()
    }

    open fun hasLoadMore(): Boolean {
        return true
    }

    inner class InnerRecyclerViewModel :
        BaseRequestListViewModel<T>(generateRequest(), hasLoadMore()) {

        override fun transform(
            position: Int,
            model: T
        ): Observable<RecyclerItemViewModel<out IModel>> {
            return this@BaseRequestListActivity.transform(position, model)
        }


        override fun transformEvent(event: Observable<IEvent>): Observable<IEvent> {
            return super.transformEvent(
                Observable.merge(
                    event,
                    this@BaseRequestListActivity.transformEvent()
                )
            )
        }

        override fun transformMutation(mutation: Observable<IMutation>): Observable<IMutation> {
            return super.transformMutation(
                Observable.merge(
                    mutation,
                    this@BaseRequestListActivity.transformMutation()
                )
            )
        }

        override fun header(cache: Boolean): Observable<RecyclerItemViewModel<out IModel>> {
            return this@BaseRequestListActivity.header(cache)
        }
    }

}