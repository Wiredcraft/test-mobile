package cn.hakim.animationapplication

import android.arch.lifecycle.LifecycleActivity
import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.util.Log
import android.widget.Toast

import org.reactivestreams.Subscription

import cn.hakim.animationapplication.viewmodel.WeatherModelFactory
import cn.hakim.animationapplication.viewmodel.WeatherViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.annotations.NonNull
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.functions.Action
import io.reactivex.functions.Consumer
import io.reactivex.schedulers.Schedulers

/**
 * Created by Administrator on 2017/6/28.
 */

class SunActivity : LifecycleActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sun)
        initView()
    }

    private fun initView() {
        mViewModelFactory = Injection.provideViewModelFactory(this)
        mViewModel = ViewModelProviders.of(this, mViewModelFactory!!).get<WeatherViewModel>(WeatherViewModel::class.java!!)
    }

    internal var level = 0
    private fun initData() {
        refreshWeather()

        mDisposable.add(mViewModel!!.getWeatherLevel(1)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnCancel { Log.e(TAG, "doOnCancel") }.doOnComplete { Log.e(TAG, "doOnComplete") }
                .subscribe({ integer ->
                    level = integer!!
                    Log.e(TAG,"level = "+level)
                    Toast.makeText(this@SunActivity, "level = " + integer, Toast.LENGTH_SHORT).show()
                }, { throwable ->
                    Log.e("读取失败", throwable.message)
                    throwable.printStackTrace()
                }, //onComplete也没有执行，当sql查询为空时，丢失事件了。。
                {
                    if (level == 0) {
                        refreshWeather()
                    }
                })
        )
    }

    override fun onStart() {
        super.onStart()
        initData()
    }


    private var mViewModelFactory: WeatherModelFactory? = null
    private var mViewModel: WeatherViewModel? = null
    private val mDisposable = CompositeDisposable()
    override fun onStop() {
        super.onStop()
        mDisposable.clear()
    }

    private fun refreshWeather() {
        mDisposable.add(mViewModel!!.refreshWeather(1)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({ }) { throwable ->
                    throwable.printStackTrace()
                    //                        Log.e(TAG, "Unable to update weather", throwable.ge);
                })
    }

    companion object {

        private val TAG = "SunActivity"
    }

}
