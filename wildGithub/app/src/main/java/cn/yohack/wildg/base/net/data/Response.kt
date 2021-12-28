package cn.yohack.wildg.base.net.data

import cn.yohack.wildg.base.net.LIST_NO_TOTAL
import cn.yohack.wildg.base.net.NET_ERROR_UNKNOWN
import cn.yohack.wildg.base.net.NET_SUCCESS
import com.google.gson.annotations.SerializedName

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description baseResponse
 **/

/**
 * base response
 */
class BaseResponse<T>() {
    /**
     * for convert
     * @param code current page
     * @param msg
     * @param data
     */
    constructor(code: Int, msg: String?, data: T?) : this() {
        this.code = code
        this.msg = msg
        this.data = data
    }

    /**code **/
    var code: Int = NET_SUCCESS

    /** msg **/
    var msg: String? = null

    /** data **/
    var data: T? = null

    /** 网络请求成功 **/
    fun success() = code == NET_SUCCESS
}

/**
 * in app pageDTO
 */
class PageDTO<T>() {

    /**
     * for convert
     * @param curPage current page
     * @param totalCount
     * @param items
     */
    constructor(curPage: Int, pSize: Int, totalCount: Int = 0, items: List<T>?) : this() {
        this.curPage = curPage
        this.pSize = pSize
        this.totalCount = totalCount
        this.items = items
    }

    /** curPage **/
    var curPage: Int = 0

    /** page Size **/
    var pSize: Int = 0

    /**
     * totalCount
     * -1 说明没有这个字段， 防止某些 api 不返回 total 字段  LIST_NO_TOTAL
     **/
    var totalCount: Int = 0

    /** page Size **/
    var items: List<T>? = null

    /**
     * 判断是否有更多
     */
    fun hasMore(lastSize: Int): Boolean {
        return if (totalCount >= 0) {
            // 如果没有条数这个字段，使用当次返回的条数和
            items?.size ?: 0 >= pSize
        } else {
            (lastSize + (items?.size ?: 0)) < totalCount
        }
    }
}


/**
 * github pageDTO
 */
class GithubPageDTO<T> {
    /** error msgs **/
    var message: String? = null

    /** total result count**/
    @SerializedName("total_count")
    var totalCount: Int = 0

    /** page items **/
    var items: List<T>? = null


    /**
     * convert 统一的格式 以便处理
     */
    fun convertInAppResponse(p: Int, pSize: Int): BaseResponse<PageDTO<T>> {
        return when {
            message.isNullOrBlank().not() -> {
                // 发生请求错误
                BaseResponse(NET_ERROR_UNKNOWN, message, null)
            }
            totalCount == 0 -> {
                // 请求的数据为空
                BaseResponse(LIST_NO_TOTAL, "", null)
            }
            else -> {
                // 数据正常返回
                val pageDto = PageDTO(p, pSize, totalCount, items)
                BaseResponse(NET_SUCCESS, null, pageDto)
            }
        }
    }
}