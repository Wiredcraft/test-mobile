package com.andzhv.githubusers.items.base

import android.view.View
import com.adgvcxz.addTo
import com.adgvcxz.recyclerviewmodel.IDefaultView
import com.adgvcxz.recyclerviewmodel.ItemViewHolder
import com.adgvcxz.recyclerviewmodel.LoadingItemViewModel
import com.andzhv.githubusers.R

/**
 * Created by zhaowei on 2021/9/11.
 */
class ItemLoadingView : IDefaultView<LoadingItemViewModel> {

    override val layoutId = R.layout.item_load_more

    override fun bind(viewHolder: ItemViewHolder, viewModel: LoadingItemViewModel, position: Int) {
        viewModel.model.map { it.state }
            .subscribe {
                when (it) {
                    LoadingItemViewModel.Failure -> {
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreProgress).visibility =
                            View.GONE
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreRetry).visibility =
                            View.VISIBLE
                    }
                    LoadingItemViewModel.Success -> {
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreProgress).visibility =
                            View.GONE
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreRetry).visibility =
                            View.GONE
                    }
                    else -> {
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreProgress).visibility =
                            View.VISIBLE
                        viewHolder.itemView.findViewById<View>(R.id.itemLoadMoreRetry).visibility =
                            View.GONE
                    }
                }
            }.addTo(viewHolder.disposables)
    }
}