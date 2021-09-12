package com.andzhv.githubusers.items.base

import android.view.View
import androidx.core.view.isVisible
import com.adgvcxz.add
import com.adgvcxz.recyclerviewmodel.LoadingItemViewModel
import com.adgvcxz.toBind
import com.andzhv.githubusers.R
import com.andzhv.githubusers.databinding.ItemLoadMoreBinding
import io.reactivex.rxjava3.disposables.CompositeDisposable

/**
 * Created by zhaowei on 2021/9/11.
 */
class ItemLoadingView : ItemBindingView<ItemLoadMoreBinding, LoadingItemViewModel> {

    override val layoutId = R.layout.item_load_more

    override fun generateViewBinding(view: View): ItemLoadMoreBinding {
        return ItemLoadMoreBinding.bind(view)
    }

    override fun bind(
        binding: ItemLoadMoreBinding,
        viewModel: LoadingItemViewModel,
        position: Int,
        disposable: CompositeDisposable
    ) {
        viewModel.toBind(disposable) {
            add({ state }, {
                binding.progress.isVisible = this == LoadingItemViewModel.Loading
                binding.retry.isVisible = this == LoadingItemViewModel.Failure
            })
        }
    }
}