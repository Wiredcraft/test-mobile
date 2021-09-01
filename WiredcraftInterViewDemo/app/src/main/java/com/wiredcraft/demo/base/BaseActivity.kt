package com.wiredcraft.demo.base

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import com.wiredcraft.demo.BR
import javax.inject.Inject

abstract class BaseActivity<VM : BaseViewModel, VDB : ViewDataBinding> : AppCompatActivity() {
    @Inject
    lateinit var vm: VM

    lateinit var binding: VDB

    abstract var layoutId: Int

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        vm.arguments = intent.extras ?: Bundle()

        vm.setLifecycleOwner(lifecycle)

        binding = DataBindingUtil.setContentView(this, layoutId)
        binding.setVariable(BR.vm, vm)
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        vm.arguments = intent?.extras ?: Bundle()
        vm.onNewIntent()
    }

    override fun onResume() {
        super.onResume()
        vm.onShown()
    }

    override fun onPause() {
        super.onPause()
        vm.onHidden()
    }

    override fun onBackPressed() {
        if (vm.onBackPress()) super.onBackPressed()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        data?.let {
            vm.onActivityResult(requestCode, it)
        }
        supportFragmentManager.fragments.forEach {
            handleResult(data, resultCode, requestCode, it)
        }
    }

    private fun handleResult(
        data: Intent?,
        resultCode: Int,
        requestCode: Int,
        frag: Fragment?
    ) {
        frag?.onActivityResult(requestCode, resultCode, data)
        frag?.childFragmentManager?.fragments?.forEach {
            handleResult(data, resultCode, requestCode, it)
        }
    }
}
