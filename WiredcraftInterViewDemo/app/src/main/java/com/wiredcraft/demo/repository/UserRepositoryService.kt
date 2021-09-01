package com.wiredcraft.demo.repository

import com.wiredcraft.demo.network.businessConvert
import com.wiredcraft.demo.repository.model.UserListDto
import io.reactivex.Observable
import javax.inject.Inject

class UserRepositoryService @Inject constructor(
    private val userApiService: UserApiService
) {

    fun fetchUserList(
        page: Int,
        keywords: String
    ): Observable<List<UserListDto>> {
        return userApiService.fetchUserList(page, keywords).businessConvert()
    }
}