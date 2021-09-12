package com.andzhv.githubusers.ui

import android.content.Context
import android.os.Bundle
import android.view.MotionEvent
import android.view.inputmethod.InputMethodManager
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.adgvcxz.*
import com.adgvcxz.recyclerviewmodel.ForceRefresh
import com.adgvcxz.recyclerviewmodel.IView
import com.adgvcxz.recyclerviewmodel.RecyclerItemViewModel
import com.andzhv.githubusers.R
import com.andzhv.githubusers.bean.SimpleUserBean
import com.andzhv.githubusers.databinding.ActivityMainBinding
import com.andzhv.githubusers.items.user.ItemUserView
import com.andzhv.githubusers.items.user.ItemUserViewModel
import com.andzhv.githubusers.request.base.BaseListRequest
import com.andzhv.githubusers.request.search.SearchUserListRequest
import com.andzhv.githubusers.ui.base.BaseRequestListActivity
import com.andzhv.githubusers.utils.SetKeyboardShow
import com.andzhv.githubusers.utils.SetKeywords
import com.andzhv.githubusers.utils.ex.just
import com.andzhv.githubusers.utils.ex.observeKeyboardChange
import com.jakewharton.rxbinding4.view.clicks
import com.jakewharton.rxbinding4.widget.textChanges
import io.reactivex.rxjava3.core.Observable
import java.util.concurrent.TimeUnit

/**
 * Created by zhaowei on 2021/9/10.
 */

class MainActivity : BaseRequestListActivity<SimpleUserBean>() {

    companion object {
        const val KEYWORDS = "Android"
    }

    override val recyclerView: RecyclerView by lazy { binding.recyclerView }
    private val binding: ActivityMainBinding by generateViewBinding { ActivityMainBinding.bind(it) }

    private val mainViewModel: MainViewModel = MainViewModel()
    override val layoutId: Int = R.layout.activity_main
    private var request = SearchUserListRequest(KEYWORDS)

    override fun initView(savedInstanceState: Bundle?) {
        super.initView(savedInstanceState)
        refreshLayout = binding.refreshLayout
    }

    override fun initBinding() {
        super.initBinding()
        mainViewModel.toBind(disposables) {
            add({ keyboardShowing }, { if (!this) binding.searchEditText.clearFocus() })
            add({ keywords }, {
                request.keywoard = if (this.isEmpty()) KEYWORDS else this
                //Cancel the api request being processed and send a new request
                viewModel.action.onNext(ForceRefresh)
            })
            add({ keywords.isEmpty() }, { binding.close.isVisible = !this })
        }

        observeKeyboardChange().distinctUntilChanged().map(::SetKeyboardShow)
            .bindTo(mainViewModel.action).addTo(disposables)

        mainViewModel.toEventBind(disposables) {
            add(
                { textChanges().filter { it.toString().isEmpty() } },
                binding.searchEditText,
                { SetKeywords("") })
            add(
                {
                    textChanges().map { it.toString() }.debounce(300, TimeUnit.MILLISECONDS)
                        .filter { it.isNotEmpty() }
                },
                binding.searchEditText,
                { SetKeywords(this) }
            )
            addAction({ clicks() }, binding.close, { binding.searchEditText.setText("") })
        }
    }

    override fun generateItemView(viewModel: RecyclerItemViewModel<out IModel>): IView<*, *> {
        return ItemUserView()
    }

    override fun generateRequest(): BaseListRequest<SimpleUserBean> {
        return request
    }

    override fun transform(
        position: Int,
        model: SimpleUserBean
    ): Observable<RecyclerItemViewModel<out IModel>> {
        return ItemUserViewModel(model).just()
    }


    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        if (ev?.action == MotionEvent.ACTION_DOWN && mainViewModel.currentModel().keyboardShowing) {
            val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(window.decorView.windowToken, 0)
        }
        return super.dispatchTouchEvent(ev)
    }

}

