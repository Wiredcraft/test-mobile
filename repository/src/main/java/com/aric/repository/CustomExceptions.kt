package com.aric.repository
import okhttp3.Interceptor
import okio.IOException

open class ApiException(val code: Int, message: String) : IOException(message)

class NotFoundException : ApiException(404, "Not found")
class UnauthorizedException : ApiException(401, "Unauthorized")
class InternalServerErrorException : ApiException(500, "Internal server error")