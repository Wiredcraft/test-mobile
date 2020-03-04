package com.wiredcraft.testmoblie.ui

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.wiredcraft.testmoblie.R
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.layout_app_bar.*


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initToolbar()
        initView()
    }

    private fun initToolbar() {
        toolbar.title = resources.getString(R.string.home_page)
    }

    private fun initView() {
        swipe_refresh_layout.setColorSchemeResources(R.color.colorPrimary)
        swipe_refresh_layout.setOnRefreshListener {
            initData()
        }
    }

    private fun initData() {

    }
}
