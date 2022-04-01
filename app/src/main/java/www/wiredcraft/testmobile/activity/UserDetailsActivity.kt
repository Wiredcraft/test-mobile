package www.wiredcraft.testmobile.activity

import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.gson.reflect.TypeToken
import www.wiredcraft.testmobile.R
import www.wiredcraft.testmobile.adapter.ReposAdapter
import www.wiredcraft.testmobile.api.MApi
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.base.BaseActivity
import www.wiredcraft.testmobile.constant.MConstants
import www.wiredcraft.testmobile.databinding.ActivityUserDetailsBinding
import www.wiredcraft.testmobile.viewmodel.UserDetailsViewModel

/**
 *@Description:
 * # UserDetails
 * #0000      @Author: tianxiao     2022/4/01      onCreate
 */
class UserDetailsActivity : BaseActivity<ActivityUserDetailsBinding, UserDetailsViewModel>() {

    override fun onResume() {
        super.onResume()
        setStatusBarColor(R.color.color_1A1A1A)
    }

    override fun createViewModel(): UserDetailsViewModel {
        return UserDetailsViewModel()
    }

    override fun layoutId(): Int {
        return R.layout.activity_user_details
    }

    override fun initialize(savedInstanceState: Bundle?) {
        binding.vm = viewModel
        binding.rv.layoutManager = LinearLayoutManager(this)
        intent?.getStringExtra(MConstants.KEY_Data)?.let {
            MApi.INITIALIZATION.gson.fromJson<Item>(
                it,
                object : TypeToken<Item>() {}.type
            )?.let { data ->
                viewModel.userData.set(data)
                viewModel.searcheRepos(data.login)
                binding.rv.adapter = ReposAdapter(viewModel.reposlist,data.avatar_url)
            }
        }
    }

    override fun finish() {
        setResult(RESULT_OK)
        super.finish()
    }

}