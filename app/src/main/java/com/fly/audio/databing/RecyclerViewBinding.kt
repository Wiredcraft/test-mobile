package com.fly.audio.databing

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView

/**
 * Created by likainian on 2021/7/13
 * Description:  自定义recycler绑定
 */

object RecyclerViewBinding {
    private const val ADAPTER = BINDING_PREFIX + "recyclerview_adapter"
    private const val LAYOUT_MANAGER = BINDING_PREFIX + "recyclerview_layoutManager"
    private const val ITEM_DECORATION = BINDING_PREFIX + "recyclerview_itemDecoration"
    private const val TOUCH_HELP = BINDING_PREFIX + "recyclerview_touchHelp"

    @JvmStatic
    @BindingAdapter(
        value = [ADAPTER, LAYOUT_MANAGER, ITEM_DECORATION, TOUCH_HELP],
        requireAll = false
    )
    fun <T, A : RecyclerView.Adapter<T>> setAdapter(
        rv: RecyclerView,
        adapter: A?,
        layoutManager: RecyclerView.LayoutManager?,
        itemDecoration: RecyclerView.ItemDecoration?,
        touchHelp: ItemTouchHelper?
    ) {
        adapter?.let {
            rv.adapter = adapter
        }

        layoutManager?.let {
            if (rv.layoutManager == null && rv.layoutManager != layoutManager) rv.layoutManager =
                layoutManager
        }

        itemDecoration?.let {
            rv.addItemDecoration(it)
        }

        touchHelp?.let {
            it.attachToRecyclerView(rv)
        }
    }
}
