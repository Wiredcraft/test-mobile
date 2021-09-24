package com.yxf.githubuserlist.module.userlist

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import coil.load
import com.yxf.clippathlayout.PathInfo
import com.yxf.clippathlayout.pathgenerator.CirclePathGenerator
import com.yxf.githubuserlist.R
import com.yxf.githubuserlist.databinding.ItemUserBinding
import com.yxf.githubuserlist.model.UserInfo
import com.yxf.githubuserlist.model.bean.PageDetail
import java.lang.ref.WeakReference

class UserListAdapter(
    private var userInfoList: List<UserInfo>,
    private val pageLoader: PageLoader
) :
    RecyclerView.Adapter<UserItemHolder>() {


    fun updateList(infoList: List<UserInfo>) {
        userInfoList = infoList
        notifyDataSetChanged()
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UserItemHolder {
        return ItemUserBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            .run {
                PathInfo.Builder(CirclePathGenerator(), avatar)
                    .create()
                    .apply()
                UserItemHolder(this)
            }
    }

    override fun onBindViewHolder(holder: UserItemHolder, position: Int) {
        val info = userInfoList[position]
        var detail = info.detailReference?.get()
        if (detail == null) {
            val pageDetail = pageLoader.getPage(info.page)
            if (pageDetail == null) {
                pageLoader.loadPage(info.page)
                //TODO : show empty view
                return
            } else {
                detail = pageDetail.userDetailList[info.index]
                info.detailReference = WeakReference(detail)
            }
        }
        holder.vb.run {
            avatar.load(detail.avatarUrl) { placeholder(R.mipmap.ic_github) }
            name.text = detail.login
            score.text = detail.score.toString()
            url.text = detail.htmlUrl
        }
    }

    override fun getItemCount(): Int {
        return userInfoList.size
    }
}


class UserItemHolder(val vb: ItemUserBinding) : RecyclerView.ViewHolder(vb.root) {

}

interface PageLoader {

    fun loadPage(page: Int)

    fun getPage(page: Int): PageDetail?

}