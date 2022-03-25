package com.wiredcraft.example.util

import androidx.test.espresso.IdlingResource
import java.util.concurrent.atomic.AtomicInteger
import kotlin.jvm.Volatile

class SimpleCountingIdlingResource(private val mResourceName: String) : IdlingResource {
    //这个counter值就像一个标记，默认为0
    private val counter = AtomicInteger(0)

    @Volatile
    private var resourceCallback: IdlingResource.ResourceCallback? = null
    override fun getName(): String {
        return mResourceName
    }

    override fun isIdleNow(): Boolean {
        return counter.get() == 0
    }

    override fun registerIdleTransitionCallback(resourceCallback: IdlingResource.ResourceCallback) {
        this.resourceCallback = resourceCallback
    }

    //每当我们开始异步请求，把counter值+1
    fun increment() {
        counter.getAndIncrement()
    }

    //当我们获取到网络数据后，counter值-1；
    fun decrement() {
        val counterVal = counter.decrementAndGet()
        //如果这时counter == 0，说明异步结束，执行回调。
        if (counterVal == 0) {
            //
            if (null != resourceCallback) {
                resourceCallback!!.onTransitionToIdle()
            }
        }
        require(counterVal >= 0) {
            //如果小于0，抛出异常
            "Counter has been corrupted!"
        }
    }
}