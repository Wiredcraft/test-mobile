package com.fly.audio.api

import com.fly.audio.ext.applyScheduler
import com.fly.core.network.RetrofitClient
import io.reactivex.Observable
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import java.io.File

/**
 * Created by likainian on 2021/7/15
 * Description:转上传参数
 */

class UploadRepo {
    private var apiServer= RetrofitClient.instance.create(UploadApi::class.java)

    fun upload(file: File): Observable<String> {
        val requestBody: RequestBody =
            RequestBody.create(MediaType.parse("multipart/form-data"), file)
        val part = MultipartBody.Part.createFormData("images", file.getName(), requestBody)
        return apiServer.requestUpload(part).applyScheduler()
    }
}