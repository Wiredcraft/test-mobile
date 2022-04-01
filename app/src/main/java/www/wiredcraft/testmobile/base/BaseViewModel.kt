package www.wiredcraft.testmobile.base

import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import www.wiredcraft.testmobile.viewmodel.ViewModelFactory

/**
 * @Description: #
 *
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
abstract class BaseViewModel : ViewModel(), LifecycleObserver {

    companion object {

        /**
         * 创建视图模型工厂
         * @param viewModel
         */
        @JvmStatic
        fun <T : BaseViewModel> createViewModelFactory(viewModel: T): ViewModelProvider.Factory {
            return ViewModelFactory(viewModel)
        }
    }
}