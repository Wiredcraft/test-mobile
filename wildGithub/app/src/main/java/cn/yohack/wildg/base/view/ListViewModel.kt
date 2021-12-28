package cn.yohack.wildg.base.view

import androidx.lifecycle.MutableLiveData
import cn.yohack.wildg.base.net.COMMON_PAGE_START
import cn.yohack.wildg.base.net.ListDataUiState
import cn.yohack.wildg.service.DEFAULT_P_SIZE

/**
 * @Author yo_hack
 * @Description
 **/
abstract class ListViewModel<T> : BaseViewModel() {

    /**
     * cur page
     */
    protected var page: Int = COMMON_PAGE_START

    /**
     * page Size
     */
    protected var pageSize: Int = DEFAULT_P_SIZE

    /**
     * list data
     */
    var data = MutableLiveData<ListDataUiState<T>>()


}