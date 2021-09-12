import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.adgvcxz.IModel
import com.adgvcxz.addTo
import com.adgvcxz.bindTo
import com.adgvcxz.recyclerviewmodel.*
import com.andzhv.githubusers.R
import com.andzhv.githubusers.items.base.ItemLoadingView
import com.andzhv.githubusers.ui.base.BaseActivity
import com.jakewharton.rxbinding4.swiperefreshlayout.refreshes

/**
 * Created by zhaowei on 2021/9/10.
 */
abstract class BaseListActivity<T : RecyclerViewModel> : BaseActivity<T, RecyclerModel>() {

    abstract val recyclerView: RecyclerView

    var refreshLayout: SwipeRefreshLayout? = null

    val items: List<RecyclerItemViewModel<out IModel>> get() = viewModel.currentModel().items

    override fun initView(savedInstanceState: Bundle?) {
        super.initView(savedInstanceState)
        recyclerView.layoutManager = generateLayoutManager()
    }

    override fun initBinding() {
        super.initBinding()
        setAdapter()
        refreshLayout?.run {
            setColorSchemeResources(R.color.textPrimary)
            setProgressBackgroundColorSchemeResource(R.color.refreshBackgroundColor)
            viewModel.model.map { it.isRefresh }
                .filter { it != isRefreshing }
                .subscribe { post { isRefreshing = it } }
                .addTo(disposables)

            refreshes().map { Refresh }
                .bindTo(viewModel.action)
                .addTo(disposables)
        }
        viewModel.action.onNext(Refresh)
    }

    open fun setAdapter() {
        val adapter = RecyclerAdapter(viewModel) {
            when (it) {
                is LoadingItemViewModel -> ItemLoadingView()
                else -> generateItemView(it)
            }
        }
        recyclerView.adapter = adapter
        initBinding(adapter)
    }

    open fun initBinding(adapter: RecyclerAdapter) {

    }

    open fun generateLayoutManager(): RecyclerView.LayoutManager = LinearLayoutManager(this)

    abstract fun generateItemView(viewModel: RecyclerItemViewModel<out IModel>): IView<*, *>

}