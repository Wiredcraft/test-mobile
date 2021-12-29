package cn.yohack.wildg

import android.view.LayoutInflater
import cn.yohack.wildg.base.view.BaseActivity
import cn.yohack.wildg.base.view.BaseViewModel
import cn.yohack.wildg.databinding.ActivityMainBinding


/**
 * main activity
 */
class MainActivity : BaseActivity<ActivityMainBinding, BaseViewModel>() {




    override fun getVMClazz(): Class<BaseViewModel> = BaseViewModel::class.java

    override fun createBinding(layoutInflater: LayoutInflater): ActivityMainBinding =
        ActivityMainBinding.inflate(layoutInflater)

}