package com.fly.core.bus

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.LifecycleOwner
import io.reactivex.functions.Consumer
import io.reactivex.subjects.PublishSubject
import io.reactivex.subjects.Subject


/**
 * Created by likainian on 2021/7/13
 * Description:  事件，代替广播
 */

class RxBus private constructor() {
    private val _bus: Subject<Event> = PublishSubject.create()

    fun send(id: Int) {
        _bus.onNext(Event(id))
    }

    fun send(id: Int,obj:Any) {
        _bus.onNext(Event(id, obj))
    }

    fun subscribe(owner: LifecycleOwner, sub: Consumer<Event>?) {
        val subscribe = _bus
            .subscribe(sub, {
                it.printStackTrace()
            })
        owner.lifecycle.addObserver(LifecycleEventObserver { source, event ->
            if (event == Lifecycle.Event.ON_DESTROY) {
                subscribe.dispose()
            }
        })
    }

    companion object {
        private var bus: RxBus? = null
            get() {
                if (field == null) {
                    field = RxBus()
                }
                return field
            }

        fun get(): RxBus {
            return bus ?: RxBus()
        }
    }

    class Event(val id: Int,var any: Any? = null)
}