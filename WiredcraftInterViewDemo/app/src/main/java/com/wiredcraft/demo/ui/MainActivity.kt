package com.wiredcraft.demo.ui

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import androidx.core.widget.addTextChangedListener
import com.wiredcraft.demo.R
import com.wiredcraft.demo.base.BaseActivity
import com.wiredcraft.demo.databinding.ActivityMainBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : BaseActivity<MainViewModel, ActivityMainBinding>() {

    override var layoutId = R.layout.activity_main

    private var imm: InputMethodManager? = null

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        imm = getSystemService(INPUT_METHOD_SERVICE) as? InputMethodManager

        binding.searchBar.addTextChangedListener {
            vm.onEditTextChanged(it.toString())
        }

        binding.recycler.setOnTouchListener { v, _ ->
            imm?.hideSoftInputFromWindow(v.windowToken, 0)
            false
        }
    }
}