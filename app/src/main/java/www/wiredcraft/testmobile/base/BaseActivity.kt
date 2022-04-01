package www.wiredcraft.testmobile.base

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.lifecycle.ViewModelProvider
import com.dylanc.activityresult.launcher.StartActivityLauncher
import com.gyf.immersionbar.ktx.immersionBar


/**
 * @Description: #
 * @param B ViewDataBinding
 * @param vm BaseViewModel
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
abstract class BaseActivity<B : ViewDataBinding, VM : BaseViewModel> : AppCompatActivity() {

    protected lateinit var viewModel: VM
    protected lateinit var binding: B
    protected val startActivityLauncher = StartActivityLauncher(this)
    /**
     * 注入模具
     */
    private fun injectViewModel() {
        binding = DataBindingUtil.setContentView(this, layoutId())
        val vm = createViewModel()
        viewModel = ViewModelProvider(this, BaseViewModel.createViewModelFactory(vm))
            .get(vm::class.java)
        lifecycle.addObserver(viewModel)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        injectViewModel()
        initialize(savedInstanceState)
    }

    /**
     * 获取 viewmodel
     */
    fun getActivityViewModel(): VM {
        return viewModel
    }

    override fun onDestroy() {
        super.onDestroy()
        binding.unbind()
        lifecycle.removeObserver(viewModel)
    }

    /**
     * 创建 viewmodel
     */
    protected abstract fun createViewModel(): VM

    /**
     * 配置 layout
     */
    protected abstract fun layoutId(): Int

    /**
     *  初始化操作
     *  @param savedInstanceState
     */
    protected abstract fun initialize(savedInstanceState: Bundle?)

    /**
     *  设置状态栏
     *  @param  barColor
     *  @param textColor
     */
     fun setStatusBarColor( barColor:Int){
        immersionBar {
            statusBarColor(barColor)
            navigationBarColor(barColor)
            autoStatusBarDarkModeEnable(true,0.2f)
        }
    }
}