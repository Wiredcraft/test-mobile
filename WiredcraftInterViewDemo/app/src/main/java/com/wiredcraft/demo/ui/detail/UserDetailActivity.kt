package com.wiredcraft.demo.ui.detail

import com.wiredcraft.demo.R
import com.wiredcraft.demo.base.BaseActivity
import com.wiredcraft.demo.databinding.ActivityUserDetailBinding
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_user_detail.*

@AndroidEntryPoint
class UserDetailActivity
    : BaseActivity<UserDetailViewModel, ActivityUserDetailBinding>() {

    override var layoutId = R.layout.activity_user_detail

    override fun onBackPressed() {
        if (web.canGoBack()) {
            web.goBack()
        } else {
            super.onBackPressed()
        }
    }
}