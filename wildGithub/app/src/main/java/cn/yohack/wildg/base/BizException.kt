package cn.yohack.wildg.base

import java.lang.RuntimeException

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description  business exception
 **/
class BizException(val code: Int, msg: String) : RuntimeException(msg)