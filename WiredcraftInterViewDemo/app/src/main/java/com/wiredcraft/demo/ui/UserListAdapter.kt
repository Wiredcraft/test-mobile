package com.wiredcraft.demo.ui

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.wiredcraft.demo.R
import com.wiredcraft.demo.databinding.ItemUserBinding
import com.wiredcraft.demo.repository.model.UserListDto

class UserListAdapter(
    val vm: MainViewModel
) : RecyclerView.Adapter<UserListAdapter.ViewHolder>() {

    private var data: MutableList<UserListDto> = mutableListOf()

    override fun getItemCount(): Int {
        return data.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindData(data[position])
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflate = LayoutInflater.from(parent.context)
        val view = inflate.inflate(R.layout.item_user, parent, false)
        return ViewHolder(view)
    }

    fun setData(users: List<UserListDto>, isRefresh: Boolean = false) {
        when (isRefresh) {
            true -> {
                data.clear()
                setData(users, false)
            }
            false -> {
                data.addAll(users)
                notifyDataSetChanged()
            }
        }
    }

    inner class ViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        private val bind = DataBindingUtil.bind<ItemUserBinding>(v)

        fun bindData(dto: UserListDto) {
            bind?.vm = vm
            bind?.data = dto
            bind?.executePendingBindings()
        }
    }
}
