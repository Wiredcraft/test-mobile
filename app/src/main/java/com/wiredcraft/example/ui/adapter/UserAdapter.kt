package com.wiredcraft.example.ui.adapter

import android.view.View
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.chad.library.adapter.base.module.LoadMoreModule
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import com.chad.library.adapter.base.module.BaseLoadMoreModule
import androidx.databinding.BindingAdapter
import com.makeramen.roundedimageview.RoundedImageView
import com.bumptech.glide.Glide
import com.wiredcraft.example.R
import com.wiredcraft.example.databinding.ItemUserBinding
import com.wiredcraft.example.entity.User
import com.wiredcraft.example.listener.OnItemClickListenerWC
/**
 * @author 武玉朋
 *
 */
class UserAdapter : BaseQuickAdapter<User, BaseViewHolder>(R.layout.item_user), LoadMoreModule {
    private var onItemClickListenerWC: OnItemClickListenerWC<User>? = null
    fun setOnItemClickListener(onItemClickListenerWC: OnItemClickListenerWC<User>?) {
        this.onItemClickListenerWC = onItemClickListenerWC
    }

    override fun onItemViewHolderCreated(viewHolder: BaseViewHolder, viewType: Int) {
        DataBindingUtil.bind<ViewDataBinding>(viewHolder.itemView)
    }

    override fun convert(helper: BaseViewHolder, item: User) {
        val binding: ItemUserBinding = helper.getBinding()!!
        binding.user = item
        binding.executePendingBindings()
        if (item.follow) {
            binding.btnFollow.text = "取消"
        } else {
            binding.btnFollow.text = "关注"
        }
        binding.btnFollow.setOnClickListener { v: View? ->
            item.follow = !item.follow
            notifyDataSetChanged()
        }
        binding.root.setOnClickListener {
            if (onItemClickListenerWC != null) {
                onItemClickListenerWC!!.onClick(item,binding.imgHead)
            }
        }
    }

    /**
     * 更新关注状态变更的item
     */
    fun updateItem(user: User) {
        for (i in data.indices) {
            val item = data[i]
            if (item.id == user.id) {
                item.follow = user.follow
                notifyItemChanged(i)
                break
            }
        }
    }

    override fun addLoadMoreModule(baseQuickAdapter: BaseQuickAdapter<*, *>): BaseLoadMoreModule {
        return BaseLoadMoreModule(baseQuickAdapter)
    }

    companion object {
        @JvmStatic
        @BindingAdapter("headerUrl")
        fun header(roundedImageView: RoundedImageView?, url: String?) {
            Glide.with(roundedImageView!!).load(url).error(R.mipmap.ic_launcher).placeholder(R.mipmap.ic_launcher).into(
                roundedImageView
            )
        }
    }
}