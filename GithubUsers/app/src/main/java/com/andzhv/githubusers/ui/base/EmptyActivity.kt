package com.andzhv.githubusers.ui.base

import com.adgvcxz.AFViewModel
import com.adgvcxz.IModel

/**
 * Created by zhaowei on 2021/9/12.
 */

class EmptyViewModel : AFViewModel<IModel>() {
    override val initModel: IModel = object : IModel {}
}

abstract class EmptyActivity : BaseActivity<EmptyViewModel, IModel>() {
    override val viewModel: EmptyViewModel = EmptyViewModel()
}