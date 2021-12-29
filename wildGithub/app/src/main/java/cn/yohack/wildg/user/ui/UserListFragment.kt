package cn.yohack.wildg.user.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import cn.yohack.wildg.base.net.setListObserver
import cn.yohack.wildg.base.view.BaseFragment
import cn.yohack.wildg.databinding.FragmentUserListBinding
import cn.yohack.wildg.user.vm.UserViewModel

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description user list fragment
 **/
class UserListFragment : BaseFragment<FragmentUserListBinding, UserViewModel>() {

    private val adapter: UserAdapter = UserAdapter()

    /**
     * use activity viewModel
     */
    override val vm: UserViewModel
        get() = ViewModelProvider(requireActivity()).get(getVMClazz())

    override fun initView1() {
        initRecyclerView()

        initSearchView()

        binding.refreshLayout.setOnRefreshListener {
            requestUserList(true)
        }
        binding.refreshLayout.isRefreshing = true
    }

    /**
     * init recyclerView
     */
    private fun initRecyclerView() {
        add2UnbindAdapter(binding.rcvContent)
        adapter.loadMoreModule.setOnLoadMoreListener {
            requestUserList(false)
        }
        adapter.setOnItemClickListener { _, _, position ->

        }
        binding.rcvContent.layoutManager = LinearLayoutManager(context)
        binding.rcvContent.adapter = adapter
    }


    /**
     * init search view
     */
    private fun initSearchView() {
        binding.searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                commonHandleSearch(query)
                return true
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                commonHandleSearch(newText)
                return false
            }

        })
    }

    /**
     * common search
     */
    private fun commonHandleSearch(txt: String?) {
        if (!txt.isNullOrBlank() && vm.q != txt) {
            vm.q = txt
            requestUserList(true)
        }
    }

    /**
     *  do request
     */
    private fun requestUserList(refresh: Boolean) {
        vm.loadList(refresh)
    }

    override fun initViewModel2() {
        vm.data.observe(viewLifecycleOwner) {
            setListObserver(
                it,
                adapter,
                binding.rcvContent,
                binding.viewError.root,
                { binding.refreshLayout.isRefreshing = false },
                errorViewBlock = { code, msg ->
                    // 根据情况错误处理和对应的错误提示
                    binding.viewError.btnText.setOnClickListener {
                        requestUserList(true)
                    }
                }
            )
        }
    }

    override fun actionOnce() {
        super.actionOnce()
        requestUserList(true)
    }


    override fun getVMClazz(): Class<UserViewModel> = UserViewModel::class.java

    override fun createBinding(
        inflater: LayoutInflater, container: ViewGroup?
    ): FragmentUserListBinding = FragmentUserListBinding.inflate(inflater, container, false)
}