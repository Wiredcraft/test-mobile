package com.wiredcraft.mobileapp.net.bean

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: Data source container wrapper
 *
 * @param isSuccess Whether the data is load successfully
 * @param data Successful data，the item has a value only if isSuccess is true
 * @param errorMsg Error messages, for page prompts
 */
open class DataResult<T> (var isSuccess: Boolean, var data: T? = null, var errorMsg: String? = null)