package cn.yohack.wildg.service

import cn.yohack.wildg.base.net.data.GithubPageDTO
import cn.yohack.wildg.bean.GithubUser
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * @Author yo_hack
 * @Date 2021.12.28
 * @Description github service
 **/
interface GithubService {

    /**
     * search github user
     * @param q: query word
     * @param p: page num
     * @param size: per page size
     */
    @GET("/search/users")
    suspend fun queryUserList(
        @Query("q") q: String,
        @Query(PAGE_STR) p: Int,
        @Query(PAGE_SIZE_STR) size: Int,
    ): GithubPageDTO<GithubUser>
}