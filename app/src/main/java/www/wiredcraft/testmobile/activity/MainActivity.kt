package www.wiredcraft.testmobile.activity

import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import cn.bingoogolapple.refreshlayout.BGANormalRefreshViewHolder
import www.wiredcraft.testmobile.R
import www.wiredcraft.testmobile.api.MApi
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.base.BaseActivity
import www.wiredcraft.testmobile.constant.MConstants
import www.wiredcraft.testmobile.databinding.ActivityMainBinding
import www.wiredcraft.testmobile.interfaces.MainModelInterface
import www.wiredcraft.testmobile.viewmodel.MainViewModel

/**
 *@Description:
 * # home
 * #0000      @Author: tianxiao     2022/3/30      onCreate
 */
class MainActivity : BaseActivity<ActivityMainBinding, MainViewModel>(), MainModelInterface {

    override fun createViewModel(): MainViewModel {
        return MainViewModel()
    }

    override fun onResume() {
        super.onResume()
        setStatusBarColor(R.color.white)
    }

    override fun layoutId(): Int {
        return R.layout.activity_main
    }

    override fun initialize(savedInstanceState: Bundle?) {
        binding.vm = viewModel
        binding.rv.layoutManager = LinearLayoutManager(this)
        binding.rv.adapter = viewModel.userAdapter
        binding.fresh.run {
            setDelegate(viewModel)
            setRefreshViewHolder(BGANormalRefreshViewHolder(this@MainActivity,
                true))
        }
        viewModel.userAdapter.interfaces = this
    }

    override fun StartActivityUserDetailsForResult(item: Item, position: Int) {
        startActivityLauncher.launch<UserDetailsActivity>(
            MConstants.KEY_Data to MApi.INITIALIZATION.gson.toJson(item)) { resultCode, _ ->
            if (resultCode == RESULT_OK) {
                // 处理回调结果
                viewModel.userAdapter.notifyItemChanged(position)
            }
        }
    }


}