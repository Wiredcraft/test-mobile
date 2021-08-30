package com.fly.audio.api

import io.reactivex.Observable
import okhttp3.MultipartBody
import retrofit2.http.Multipart
import retrofit2.http.POST
import retrofit2.http.Part

/**
 * Created by likainian on 2021/7/15
 * Description: 上传api
 */

interface UploadApi {
    //文件上传
    @Multipart
    @POST("/audio")
    fun requestUpload(@Part parts:  MultipartBody.Part): Observable<String>

    //多文件上传
    @Multipart
    @POST("/audio")
    fun requestUpload(@Part parts: List<MultipartBody.Part>): Observable<String>
}