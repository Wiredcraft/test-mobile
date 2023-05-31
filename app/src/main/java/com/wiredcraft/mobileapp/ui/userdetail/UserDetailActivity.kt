package com.wiredcraft.mobileapp.ui.userdetail

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Parcel
import android.os.Parcelable
import androidx.activity.viewModels
import com.gyf.immersionbar.ktx.immersionBar
import com.wiredcraft.mobileapp.BaseActivity
import com.wiredcraft.mobileapp.R
import com.wiredcraft.mobileapp.databinding.ActivityUserDetailLayoutBinding
import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.ext.circle
import com.wiredcraft.mobileapp.ext.shareViewModels
import com.wiredcraft.mobileapp.shareviewmodel.ShareViewModel
import com.wiredcraft.mobileapp.utils.SimpleItemDecoration

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the userDetail page
 *
 * You must enter the page through the [start] method,
 * otherwise you may crash because you can't get the parameters.
 */
class UserDetailActivity : BaseActivity<ActivityUserDetailLayoutBinding>() {

    private val mViewModel by viewModels<UserDetailViewModel>()

    //Share data notifications to the home page
    private val mShareViewModel by shareViewModels<ShareViewModel>()

    private lateinit var mAdapter: UserDetailRepositoryAdapter

    companion object {

        private const val KEY_BEAN = "key_bean"

        /**
         * start UserDetailActivity
         * @param bean a part of datasource
         */
        fun start(context: Context, bean: UserDetailBean) {
            val intent = Intent(context, UserDetailActivity::class.java).apply {
                putExtra(KEY_BEAN, bean)
            }
            context.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        immersionBar {
            navigationBarColor(R.color.white)
            navigationBarDarkIcon(true)
        }
        mViewModel.userBean.value = intent.getParcelableExtra(KEY_BEAN)
        mAdapter = UserDetailRepositoryAdapter()
        initView()
        observeData()
        mViewModel.queryUserRepositories(mViewModel.userBean.value!!.name!!)
    }

    private fun initView() {
        mViewBinding.rvUserDetail.run {
            addItemDecoration(
                SimpleItemDecoration.getInstance(context)
                    .setDividerColor(R.color.color_EFEFEF)
                    .setDividerSize(1F)
            )
            adapter = mAdapter
        }

        mViewBinding.tvUserDetailFollow.setOnClickListener {
            val oldBean = mViewModel.userBean.value
            mViewModel.userBean.value = oldBean!!.copy(isFollowed = !oldBean.isFollowed)
            //notify HomePage
            mShareViewModel.followUser.value = oldBean.identifyId
        }
    }

    private fun observeData() {
        mViewModel.userBean.observe(this) { userBean ->
            mViewBinding.ivUserDetailAvatar.run {
                circle(this, userBean.avatarUrl)
            }
            mViewBinding.tvUserDetailName.text = userBean.name

            mViewBinding.tvUserDetailFollow.text = if (userBean.isFollowed) {
                resources.getString(R.string.str_followed)
            } else {
                resources.getString(R.string.str_follow)
            }
        }
        mViewModel.repositorySource.observe(this) { uiState ->
            when (uiState) {
                is UIState.Loading -> {
                    //TODO use some loading view
                }

                is UIState.Success -> {
                    if (uiState.data.isNullOrEmpty()) {
                        //TODO no data UI
                    } else {
                        mAdapter.addData(uiState.data)
                    }
                }

                is UIState.Error -> {
                    //TODO handle error view
                }

                else -> {}
            }
        }
    }

    override fun findViewBinding() = ActivityUserDetailLayoutBinding.inflate(layoutInflater)
}

/**
 * Part of UserDetail page parameters and data sources
 *
 * @param identifyId unique id
 * @param name the userName
 * @param avatarUrl head image url
 * @param isFollowed Whether it is follow or not, it has been focused on true, otherwise false
 */
data class UserDetailBean(
    val identifyId: Long,
    val name: String?,
    val avatarUrl: String?,
    val isFollowed: Boolean
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readLong(),
        parcel.readString(),
        parcel.readString(),
        parcel.readByte() != 0.toByte()
    ) {
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeLong(identifyId)
        parcel.writeString(name)
        parcel.writeString(avatarUrl)
        parcel.writeByte(if (isFollowed) 1 else 0)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<UserDetailBean> {
        override fun createFromParcel(parcel: Parcel): UserDetailBean {
            return UserDetailBean(parcel)
        }

        override fun newArray(size: Int): Array<UserDetailBean?> {
            return arrayOfNulls(size)
        }
    }
}
