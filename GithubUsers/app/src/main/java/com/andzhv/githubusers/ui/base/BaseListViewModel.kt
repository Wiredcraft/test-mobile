package com.andzhv.githubusers.ui.base

import com.adgvcxz.IModel
import com.adgvcxz.IMutation
import com.adgvcxz.recyclerviewmodel.*
import com.andzhv.githubusers.Config
import com.andzhv.githubusers.utils.just
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single

/**
 * Created by zhaowei on 2021/9/10.
 */
abstract class BaseListViewModel<M>(hasLoadMore: Boolean) : RecyclerViewModel() {

    final override val initModel: RecyclerModel = RecyclerModel(emptyList(), hasLoadMore, false)

    val items: List<RecyclerItemViewModel<out IModel>> get() = currentModel().items

    open fun getCache(): List<M> {
        return emptyList()
    }

    override fun request(refresh: Boolean): Observable<IMutation> {
        var position = if (refresh) 0 else items.filterNot { it is LoadingItemViewModel }.count()

        //Header List
        val headerSingle = if (refresh) {
            header(false).doOnNext { position += 1 }.toList()
        } else {
            Single.just(emptyList())
        }

        //Requested list
        val listSingle = getList(refresh).concatMap {
            Observable.fromIterable(it).flatMap { item ->
                transform(position, item).doOnNext { position += 1 }
            }
        }.toList()

        return headerSingle.flatMapObservable { headerList ->
            listSingle.flatMapObservable { list ->
                if (list.size < listLimit()) {
                    //If the length of the List is less than limit, delete the last LoadingItem
                    Observable.just(UpdateData(headerList + list), RemoveLoadingItem)
                } else {
                    UpdateData(headerList + list).just()
                }
            }
        }.onErrorResumeNext {
            //When an error occurs
            if (refresh) Observable.empty() else LoadFailure.just()
        }
    }


    /**
     * Send a request for List
     * @param refresh if true: refresh else load more
     */
    abstract fun getList(refresh: Boolean): Observable<List<M>>

    /**
     * Convert Model to ViewModel
     * @return Observable
     * return list: Observable.concat(A, B, C)
     * return empty: Observable.empty()
     */
    abstract fun transform(position: Int, model: M): Observable<RecyclerItemViewModel<out IModel>>

    /**
     * Add a custom ViewModel to the head of the list
     * @param cache Whether the current list comes from the cache
     */
    open fun header(cache: Boolean): Observable<RecyclerItemViewModel<out IModel>> {
        return Observable.empty()
    }

    /**
     * List length per request
     */
    open fun listLimit(): Int {
        return Config.LIST_LIMIT
    }
}