package com.testmobile.githubuserslist.api

import com.testmobile.githubuserslist.model.User
import retrofit2.http.Query
import java.io.IOException

/**
 * [FakeUsersTestApi] class extends the [UsersApi] class to
 * create a fake api in order to simulate the serach users service
 * */
class FakeUsersTestApi: UsersApi {

    private val users = User("1", "android", "2", "http://url.com", "http://url.com/user/1")
    private val usersList = arrayListOf(users);
    private var failureMsg: String? = null


    override suspend fun searchUsers(
            @Query("q") query: String,
            @Query("") page: Int,
            @Query("per_page") pageSize: Int
    ): UserResponse {
        failureMsg?.let {
            throw IOException(it)
        }

        return UserResponse(
                totalCount = usersList.size,
                results = usersList,
        )
    }

    /**
     * params -> user: [User] object
     **/
    fun addUser(user: User){
        usersList.add(user)
    }
}