package com.andzhv.githubusers.utils.ex

import android.widget.Toast
import com.andzhv.githubusers.GithubApplication

/**
 * Created by zhaowei on 2021/9/12.
 */
fun showFailedToast(message: String) {
    Toast.makeText(GithubApplication.context, message, Toast.LENGTH_SHORT).show()
}