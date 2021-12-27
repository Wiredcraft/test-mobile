package cn.yohack.wildg.base.net.data

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description baseResponse
 **/
abstract class BaseResponse<T> {
    abstract fun success(): Boolean

    abstract fun getResponseData(): T?

    abstract fun getResponseCode(): Int

    abstract fun getResponseMsg(): String?
}