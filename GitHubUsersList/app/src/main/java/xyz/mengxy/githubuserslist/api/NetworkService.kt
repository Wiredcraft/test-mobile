package xyz.mengxy.githubuserslist.api

import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query
import xyz.mengxy.githubuserslist.model.Repo
import xyz.mengxy.githubuserslist.model.UserSearchResponse

/**
 * Created by Mengxy on 3/28/22.
 */
interface NetworkService {

    // Add "per_page" parameters to get user data per page
    @GET("search/users")
    suspend fun searchUsers(
        @Query("q") query: String,
        @Query("page") page: Int,
        @Query("per_page") size: Int
    ): UserSearchResponse

    // Add "page" parameters to get repo data by page
    // Add "per_page" parameters to get repo data per page
    @GET("users/{userName}/repos")
    suspend fun getUserRepos(
        @Path("userName") userName: String,
        @Query("page") page: Int,
        @Query("per_page") size: Int
    ): List<Repo>

    companion object {
        private const val API_BASE_URL = "https://api.github.com/"

        fun create(): NetworkService {
            val loggingInterceptor = HttpLoggingInterceptor().apply {
                level = HttpLoggingInterceptor.Level.BASIC
            }

            val client = OkHttpClient.Builder()
                .addInterceptor(loggingInterceptor)
                .retryOnConnectionFailure(true)
                .build()

            return Retrofit.Builder()
                .baseUrl(API_BASE_URL)
                .client(client)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(NetworkService::class.java)
        }
    }
}
