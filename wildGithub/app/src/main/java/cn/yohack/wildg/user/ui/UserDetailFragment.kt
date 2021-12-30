package cn.yohack.wildg.user.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.addCallback
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.NavHostFragment
import cn.yohack.wildg.base.view.BaseFragment
import cn.yohack.wildg.databinding.FragmentUserDetailBinding
import cn.yohack.wildg.user.vm.UserViewModel
import com.scwang.smart.refresh.layout.api.RefreshLayout
import com.scwang.smart.refresh.layout.listener.OnRefreshLoadMoreListener

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description
 **/
class UserDetailFragment : BaseFragment<FragmentUserDetailBinding, UserViewModel>() {
    /**
     * use activity viewModel
     */
    override val vm: UserViewModel
        get() = ViewModelProvider(requireActivity()).get(getVMClazz())


    private var tempIncrease: Int = 0

    override fun initView1() {
        binding.refreshLayout.setOnRefreshLoadMoreListener(object : OnRefreshLoadMoreListener {
            override fun onRefresh(refreshLayout: RefreshLayout) {
                changeDetail(false)
            }

            override fun onLoadMore(refreshLayout: RefreshLayout) {
                changeDetail(true)
            }

        })

        binding.gWebView.progressChange = {
            if (tempIncrease == 1) {
                binding.refreshLayout.finishLoadMore(0, it, false)
            } else if (tempIncrease == -1) {
                binding.refreshLayout.finishRefresh()
            }
            tempIncrease = 0
        }
    }

    /**
     * 更换详情
     */
    private fun changeDetail(increase: Boolean) {
        val list = vm.data.value?.list
        val pos = list?.indexOf(vm.userDetail.value) ?: -1

        val failCall = {
            if (increase) {
                binding.refreshLayout.finishLoadMore(false)
            } else {
                binding.refreshLayout.finishRefresh(false)
            }
            Unit
        }

        if (pos < 0) {
            failCall.invoke()
        } else {
            if (pos < (list?.size ?: 0 - 3)) {
                vm.loadList(false)
            }
            tempIncrease = if (increase) 1 else -1
            list?.getOrNull(pos + tempIncrease)?.let {
                vm.userDetail.value = it
            } ?: kotlin.run {
                failCall.invoke()
            }
        }
    }

    override fun initViewModel2() {
        vm.userDetail.observe(viewLifecycleOwner) {
            binding.gWebView.getWebView().stopLoading()
            binding.gWebView.getWebView().loadUrl(it.htmlUrl)
        }
    }


    override fun onDestroyView() {
        binding.gWebView.destroy()
        super.onDestroyView()
    }

    override fun getVMClazz(): Class<UserViewModel> = UserViewModel::class.java

    override fun createBinding(
        inflater: LayoutInflater,
        container: ViewGroup?
    ): FragmentUserDetailBinding = FragmentUserDetailBinding.inflate(inflater, container, false)
}