package com.andzhv.githubusers

import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.viewbinding.ViewBinding
import com.adgvcxz.AFViewModel
import com.adgvcxz.IModel
import io.reactivex.rxjava3.disposables.CompositeDisposable

/**
 * Created by zhaowei on 2021/9/10.
 */

class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}