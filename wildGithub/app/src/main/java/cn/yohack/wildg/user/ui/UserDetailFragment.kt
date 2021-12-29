package cn.yohack.wildg.user.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.addCallback
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.NavHostFragment
import cn.yohack.wildg.base.view.BaseFragment
import cn.yohack.wildg.databinding.FragmentUserDetailBinding
import cn.yohack.wildg.user.vm.UserViewModel
import cn.yohack.wildg.utils.setDefaultWebSettings

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

    override fun initView1() {
        activity?.onBackPressedDispatcher?.addCallback {
            if (binding.gWebView.getWebView().canGoBack()) {
                binding.gWebView.getWebView().goBack()
            } else {
                NavHostFragment.findNavController(this@UserDetailFragment).popBackStack()
            }
        }
    }


    override fun initViewModel2() {
        vm.userDetail.observe(viewLifecycleOwner) {
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