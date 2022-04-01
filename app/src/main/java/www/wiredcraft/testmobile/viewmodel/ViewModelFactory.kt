package www.wiredcraft.testmobile.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import www.wiredcraft.testmobile.base.BaseViewModel

/**
 * @Description: #
 * @param viewModel
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
class ViewModelFactory(val viewModel: BaseViewModel) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return viewModel as T
    }
}