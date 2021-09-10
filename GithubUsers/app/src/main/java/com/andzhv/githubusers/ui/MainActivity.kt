package com.andzhv.githubusers.ui

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.andzhv.githubusers.R
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/10.
 */

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        Observable.empty<Int>().toList().subscribe { t1, t2 ->
            Log.e("zhaow", "t1  $t1")
            Log.e("zhaow", "t2  $t2")
        }
    }
}