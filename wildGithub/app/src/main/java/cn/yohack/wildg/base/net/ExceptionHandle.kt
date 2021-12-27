package cn.yohack.wildg.base.net

import cn.yohack.wildg.App
import cn.yohack.wildg.BuildConfig
import cn.yohack.wildg.R
import cn.yohack.wildg.base.BizException
import retrofit2.HttpException

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description convert network exception to bizException
 **/
fun handleNetException(e: Throwable?): BizException {
    if (BuildConfig.DEBUG) {
        e?.printStackTrace()
    }
    return when (e) {
        is HttpException -> {
            BizException(NET_ERROR_NETWORK, "")
        }
        //different connect type to handle
//        is ConnectException
//        -> BizException(NET_ERROR_NETWORK, getStringFromId(R.string.network_error))
//
//        is JSONException, is ParseException, is JsonParseException, is MalformedJsonException
//        -> BizException(NET_ERROR_PARSE, getStringFromId(R.string.parse_data_error))
//
//        is SSLException -> BizException(NET_ERROR_SSL, getStringFromId(R.string.unsafe_network))
//
//        is SocketTimeoutException, is UnknownHostException
//        -> BizException(NET_ERROR_TIMEOUT, getStringFromId(R.string.connect_timeout))

        is BizException -> e

        else -> BizException(NET_ERROR_UNKNOWN, "")
    }
}