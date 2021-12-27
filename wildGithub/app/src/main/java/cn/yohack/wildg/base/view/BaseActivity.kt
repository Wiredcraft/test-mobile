package cn.yohack.wildg.base.view

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ViewModelProvider
import androidx.viewbinding.ViewBinding
import cn.yohack.wildg.base.dialog.showLoadingDialog
import cn.yohack.wildg.utils.showMsg

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description base activity for this app
 **/
abstract class BaseActivity<VB : ViewBinding, VM : BaseViewModel>() : AppCompatActivity(),
    ILoadAndToastEvent {


    /** binding **/
    protected lateinit var binding: VB

    /** vm **/
    protected val vm: VM by lazy {
        ViewModelProvider(this).get(getVMClazz())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        beforeOnCreate0()
        super.onCreate(savedInstanceState)
        binding = createBinding(layoutInflater)
        setContentView(binding.root)
        initView1()
        registerLoadAndToastEvent()
        initViewModel2()
        actionOnce()
    }


    /**
     * get vm clazz
     */
    abstract fun getVMClazz(): Class<VM>

    /**
     *  create binding
     */
    abstract fun createBinding(layoutInflater: LayoutInflater): VB

    /**
     * flow 0 1 2
     */
    open fun beforeOnCreate0() = Unit

    /**
     * method for init view, setOnClickListener etc..
     */
    open fun initView1() = Unit

    /**
     * method for init viewModel, vm.observe etc...
     */
    open fun initViewModel2() = Unit


    /**
     * method for query network or something
     */
    protected open fun actionOnce() = Unit

    /**
     * method for query network or something
     */
    protected open fun actionAlways() = Unit

    /**
     * register common viewModel
     * use for multi register
     */
    protected open fun registerLoadAndToastEvent() {
        registerCommonVm(vm)
    }

    override fun getLOwner(): LifecycleOwner = this

    private var dialog: Dialog? = null
    override fun showLoading(msg: String?) {
        if (dialog == null) {
            dialog = showLoadingDialog(this, msg)
        } else {
            if (dialog?.isShowing != true) {
                dialog?.show()
            }
        }
    }

    override fun dismissLoading() {
        dialog?.dismiss()
        dialog = null
    }

    override fun showToast(msg: String?) {
        showMsg(msg)
    }

    override fun onResume() {
        super.onResume()
        actionAlways()
    }

    override fun onDestroy() {
        dismissLoading()
        super.onDestroy()
    }

}