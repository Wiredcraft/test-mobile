package com.fly.core.network.interceptor

import okhttp3.MediaType
import okhttp3.ResponseBody
import okio.*
import java.io.IOException

/**
 * Created by likainian on 2021/7/15
 * Description:下载文件进度
 */

class ProgressResponseBody(private val responseBody: ResponseBody) : ResponseBody() {
    override fun contentType(): MediaType? {
        return responseBody.contentType()
    }

    override fun contentLength(): Long {
        return responseBody.contentLength()
    }

    override fun source(): BufferedSource {
        return Okio.buffer(source(responseBody.source()))
    }

    private fun source(source: Source): Source {
        return object : ForwardingSource(source) {
            internal var readLength = 0L
            @Throws(IOException::class)
            override fun read(sink: Buffer, byteCount: Long): Long {
                val bytesRead = super.read(sink, byteCount)
                readLength += if (bytesRead != -1L) bytesRead else 0
                return bytesRead
            }
        }
    }
}