package cn.yohack.wildg.user.repo

import cn.yohack.wildg.base.net.GithubRetrofit
import cn.yohack.wildg.base.net.data.BaseResponse
import cn.yohack.wildg.base.net.data.PageDTO
import cn.yohack.wildg.bean.GithubUser
import cn.yohack.wildg.service.DEFAULT_P_SIZE
import cn.yohack.wildg.service.GithubService

/**
 * @Author yo_hack
 * @Date 2021.12.28
 * @Description user repository, common use dagger to inject
 **/
object UserRepository {

    /**
     * user service
     * also can inject
     */
    private val userService: GithubService =
        GithubRetrofit.INSTANCE.create(GithubService::class.java)

    /**
     * search github user
     * @param q: query word
     * @param p: page num
     * @param size: per page size default = 30  {@link userService}
     */
    suspend fun queryUserList(
        q: String,
        p: Int,
        size: Int = DEFAULT_P_SIZE
    ): BaseResponse<PageDTO<GithubUser>> {
        val list = userService.queryUserList(q, p, size)
        return list.convertInAppResponse(p, size)
    }
}