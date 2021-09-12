package com.andzhv.githubusers.ui

import com.adgvcxz.AFViewModel
import com.adgvcxz.IEvent
import com.adgvcxz.IModel
import com.adgvcxz.IMutation
import com.andzhv.githubusers.utils.SetKeyboardShow
import com.andzhv.githubusers.utils.SetKeywords
import com.andzhv.githubusers.utils.ex.just
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/12.
 */
data class MainModel(
    var keywords: String = "",
    var keyboardShowing: Boolean = false
) : IModel

class MainViewModel : AFViewModel<MainModel>() {
    override val initModel: MainModel = MainModel()

    override fun mutate(event: IEvent): Observable<IMutation> {
        if (event is IMutation) return event.just()
        return super.mutate(event)
    }

    override fun scan(model: MainModel, mutation: IMutation): MainModel {
        when (mutation) {
            is SetKeyboardShow -> model.keyboardShowing = mutation.isShow
            is SetKeywords -> model.keywords = mutation.keywords
        }
        return super.scan(model, mutation)
    }
}
