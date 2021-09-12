package com.andzhv.githubusers.items.user

import android.view.View
import com.adgvcxz.IModel
import com.adgvcxz.add
import com.adgvcxz.recyclerviewmodel.RecyclerItemViewModel
import com.adgvcxz.toBind
import com.andzhv.githubusers.R
import com.andzhv.githubusers.bean.SimpleUserBean
import com.andzhv.githubusers.databinding.ItemSimpleUserBinding
import com.andzhv.githubusers.items.base.ItemBindingView
import com.bumptech.glide.Glide
import io.reactivex.rxjava3.disposables.CompositeDisposable

/**
 * Created by zhaowei on 2021/9/11.
 */

data class ItemUserModel(
    val avatar: String,
    val username: String,
    val score: Float,
    val url: String,
) : IModel

class ItemUserViewModel(bean: SimpleUserBean) : RecyclerItemViewModel<ItemUserModel>() {
    override val initModel: ItemUserModel = bean.run {
        ItemUserModel(avatarUrl, login, score, url)
    }
}


class ItemUserView : ItemBindingView<ItemSimpleUserBinding, ItemUserViewModel> {
    override val layoutId: Int = R.layout.item_simple_user

    override fun generateViewBinding(view: View): ItemSimpleUserBinding {
        return ItemSimpleUserBinding.bind(view)
    }

    override fun bind(
        binding: ItemSimpleUserBinding,
        viewModel: ItemUserViewModel,
        position: Int,
        disposable: CompositeDisposable
    ) {
        viewModel.toBind(disposable) {
            add(
                { avatar },
                { Glide.with(binding.avatar).load(this).fitCenter().into(binding.avatar) }
            )
            add({ username }, { binding.username.text = this })
        }
    }

}