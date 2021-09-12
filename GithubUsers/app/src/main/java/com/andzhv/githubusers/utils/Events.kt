package com.andzhv.githubusers.utils

import com.adgvcxz.IEvent
import com.adgvcxz.IMutation

/**
 * Created by zhaowei on 2021/9/12.
 */
data class SetKeyboardShow(val isShow: Boolean): IEvent, IMutation
data class SetKeywords(val keywords: String): IEvent, IMutation