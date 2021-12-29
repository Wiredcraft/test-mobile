package cn.yohack.wildg.base.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import androidx.viewbinding.ViewBinding

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description base fragment for this app
 **/
abstract class BaseFragment<VB : ViewBinding, VM : BaseViewModel>() :
    AbsFragment() {


    /** vm **/
    protected open val vm: VM by lazy {
        ViewModelProvider(this).get(getVMClazz())
    }

    private var _binding: VB? = null

    /**
     * This property is only valid between onCreateView and onDestroyView.
     */
    protected val binding get() = _binding!!

    /**
     * unBind rcv lists
     */
    private var unbindRcvList: ArrayList<RecyclerView>? = null

    /**
     * 是否第一次查询过
     */
    protected var hasQuery = false

    override fun onCreate(savedInstanceState: Bundle?) {
        beforeOnCreate0()
        recoverBundle(savedInstanceState)
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = createBinding(inflater, container)
        return _binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        recoverBundle(savedInstanceState)
        super.onViewCreated(view, savedInstanceState)
        initView1()
        registerLoadAndToastEvent()
        initViewModel2()
        if (!hasQuery) {
            actionOnce()
            hasQuery = false
        }
    }

    override fun onResume() {
        super.onResume()
        actionAlways()
    }

    protected open fun recoverBundle(bundle: Bundle?) = Unit

    /**
     * method for query network or something
     */
    protected open fun actionOnce() = Unit

    /**
     * method for query network or something
     */
    protected open fun actionAlways() = Unit

    /**
     * get vm clazz
     */
    abstract fun getVMClazz(): Class<VM>

    /**
     * create binding
     */
    abstract fun createBinding(inflater: LayoutInflater, container: ViewGroup?): VB

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
     * register common viewModel
     * use for multi register
     */
    protected open fun registerLoadAndToastEvent() {
        registerCommonVm(vm)
    }

    override fun onDestroyView() {
        unbindRcvList?.forEach {
            it.adapter = null
        }
        unbindRcvList?.clear()

        _binding = null
        super.onDestroyView()
    }

    /**
     * adapter has strong reference of rcv
     */
    protected fun add2UnbindAdapter(rcv: RecyclerView) {
        if (unbindRcvList.isNullOrEmpty()) {
            unbindRcvList = ArrayList(4)
        }
        unbindRcvList?.add(rcv)
    }
}