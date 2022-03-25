package com.wiredcraft.example.net

import retrofit2.http.GET
import retrofit2.http.Url
import com.wiredcraft.example.entity.UserResponse
import com.wiredcraft.example.entity.Repo
import io.reactivex.Observable
import retrofit2.http.POST

interface HttpUserService {
    @GET
    fun getUsers(@Url url: String?): Observable<UserResponse>

    @GET
    fun getRepos(@Url url: String?): Observable<List<Repo>>
}