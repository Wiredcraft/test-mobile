package com.wiredcraft.example.net.interceptor

import android.util.Log
import com.hp.marykay.net.BaseApi
import kotlin.Throws
import okhttp3.*
import okio.Buffer
import okio.BufferedSource
import java.io.IOException
import java.lang.StringBuilder
import java.nio.charset.StandardCharsets

class LogInterceptor : Interceptor {
    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val buffer = Buffer()
        val request: Request = chain.request()
        val headers = request.headers
        Log.i(
            TAG,
            "╔════════════════════════════════════════════════════════════════════════════════════════"
        )
        if (headers != null) {
            val responseHeadersLength = headers.size
            Log.i(TAG, String.format("║ 请求地址 %s", request.url))
            Log.i(TAG, String.format("║ 请求编号 %d", request.hashCode()))
            Log.i(TAG, String.format("║ 请求方式 %s", request.method))
            Log.i(
                TAG,
                "╟────────────────────────────────────────────────────────────────────────────────────────"
            )
            for (i in 0 until responseHeadersLength) {
                val headerName = headers.name(i)
                val headerValue = headers[headerName]
                Log.i(TAG, String.format("║ 请求头: Key: %s Value: %s", headerName, headerValue))
            }
        }
        val requestBody = request.body
        if (requestBody != null) {
            Log.i(
                TAG,
                "╟────────────────────────────────────────────────────────────────────────────────────────"
            )
            requestBody.writeTo(buffer)
            Log.i(TAG, String.format("║ 请求参数 %s", buffer.readString(StandardCharsets.UTF_8)))
            Log.i(
                TAG,
                "╟────────────────────────────────────────────────────────────────────────────────────────"
            )
        }
        Log.i(TAG, "║ 等待数据返回")
        Log.i(
            TAG,
            "╚════════════════════════════════════════════════════════════════════════════════════════"
        )
        var response: Response? = null
        try {
            response = chain.proceed(request)
            val responseBody = response.body
            val source = responseBody!!.source()
            Log.i(
                TAG,
                "╔════════════════════════════════════════════════════════════════════════════════════════"
            )
            Log.i(TAG, String.format("║ 请求地址 %s", request.url))
            Log.i(TAG, String.format("║ 请求编号 %d", request.hashCode()))
            Log.i(TAG, "║ 返回数据")
            if (source == null) {
                Log.i(TAG, String.format("║ 访问错误码 %s", response.code))
            } else {
                source.request(Long.MAX_VALUE) // Buffer the entire body.
                val bufferS = source.buffer()
                val contentType = responseBody.contentType()
                if (contentType != null) {
                    val json = bufferS.clone().readString(StandardCharsets.UTF_8)
                    val con = formatJson(json).split("\n").toTypedArray()
                    for (line in con) {
                        Log.i(TAG, "║$line")
                    }
                }
            }
            Log.i(
                TAG,
                "╚════════════════════════════════════════════════════════════════════════════════════════"
            )
        } catch (e: IOException) {
            Log.i(
                TAG,
                "╔════════════════════════════════════════════════════════════════════════════════════════"
            )
            Log.i(TAG, String.format("║ 请求地址 %s", request.url))
            Log.i(TAG, String.format("║ 请求编号 %d", request.hashCode()))
            Log.i(TAG, "║ 返回数据")
            Log.i(TAG, "║" + e.message + ", " + e.localizedMessage)
            Log.i(
                TAG,
                "╚════════════════════════════════════════════════════════════════════════════════════════"
            )
            e.printStackTrace()
        }
        return response!!
    }

    companion object {
        private const val TAG = BaseApi.TAG

        /**
         * 格式化
         *
         * @param jsonStr
         * @return
         */
        fun formatJson(jsonStr: String?): String {
            if (null == jsonStr || "" == jsonStr) return ""
            val sb = StringBuilder()
            var last = '\u0000'
            var current = '\u0000'
            var indent = 0
            var isInQuotationMarks = false
            for (i in 0 until jsonStr.length) {
                last = current
                current = jsonStr[i]
                when (current) {
                    '"' -> {
                        if (last != '\\') {
                            isInQuotationMarks = !isInQuotationMarks
                        }
                        sb.append(current)
                    }
                    '{', '[' -> {
                        sb.append(current)
                        if (!isInQuotationMarks) {
                            sb.append('\n')
                            indent++
                            addIndentBlank(sb, indent)
                        }
                    }
                    '}', ']' -> {
                        if (!isInQuotationMarks) {
                            sb.append('\n')
                            indent--
                            addIndentBlank(sb, indent)
                        }
                        sb.append(current)
                    }
                    ',' -> {
                        sb.append(current)
                        if (last != '\\' && !isInQuotationMarks) {
                            sb.append('\n')
                            addIndentBlank(sb, indent)
                        }
                    }
                    else -> sb.append(current)
                }
            }
            return sb.toString()
        }

        /**
         * 添加space
         *
         * @param sb
         * @param indent
         */
        private fun addIndentBlank(sb: StringBuilder, indent: Int) {
            for (i in 0 until indent) {
                sb.append('\t')
            }
        }

        /**
         * 判断字符串是否为 null 或全为空格
         *
         * @param s 待校验字符串
         * @return `true`: null 或全空格<br></br> `false`: 不为 null 且不全空格
         */
        fun isTrimEmpty(s: String?): Boolean {
            return s == null || s.trim { it <= ' ' }.length == 0
        }
    }
}