package cn.yohack.wildg.user.vm

import androidx.lifecycle.viewModelScope
import cn.yohack.wildg.base.net.COMMON_PAGE_START
import cn.yohack.wildg.base.net.getList
import cn.yohack.wildg.base.view.ListViewModel
import cn.yohack.wildg.bean.GithubUser
import cn.yohack.wildg.user.repo.UserRepository
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description user viewModel
 **/
class UserViewModel : ListViewModel<GithubUser>() {

    /**
     * user repo can inject
     */
    private val userRepo: UserRepository by lazy { UserRepository }

    var q = "kotlin"


    /**
     * 加载 列表
     * @param refresh: 是否是刷新
     * @param curDetailId: 当前展示详情的id, 如果是 -1 就代表只加载， 如果 > 0 加载详情后， 显示详情
     */
    fun loadList(refresh: Boolean, curDetailId: Long = -1): Job {
        page = if (refresh) {
            COMMON_PAGE_START
        } else {
            data.value?.nextPage ?: page
        }

        // 当前查询值
        val curQ = q

        return viewModelScope.launch {
            getList(page, pageSize, data) { p, pSize ->
                val result = userRepo.queryUserList(curQ, p, pSize)

                if (curQ == q) {
                    result
                } else {
                    // temp set result
                    result
                }
            }

            // 展示详情需要
            if (curDetailId > 0) {

            }
        }
    }

}