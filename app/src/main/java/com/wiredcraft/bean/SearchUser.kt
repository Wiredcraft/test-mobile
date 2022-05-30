package com.wiredcraft.bean

import android.os.Parcel
import android.os.Parcelable


data class SearchUser(
    val total_count: Int = 0,
    val incomplete_results: Boolean = false,
    val items: ArrayList<UserItem> = ArrayList()
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readInt(),
        parcel.readByte() != 0.toByte(),
        parcel.createTypedArrayList(UserItem) ?: ArrayList<UserItem>(0)
    )

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeInt(total_count)
        parcel.writeByte(if (incomplete_results) 1 else 0)
        parcel.writeTypedList(items)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<SearchUser> {
        override fun createFromParcel(parcel: Parcel): SearchUser {
            return SearchUser(parcel)
        }

        override fun newArray(size: Int): Array<SearchUser?> {
            return arrayOfNulls(size)
        }
    }
}

data class UserItem(
    val id: Int = 0,
    val login: String = "",
    val avatar_url: String = "",
    val score: Int = 0,
    val html_url: String = "",
    @Transient
    var followState: Boolean = false
) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readInt(),
        parcel.readString() ?: "",
        parcel.readString() ?: "",
        parcel.readInt(),
        parcel.readString() ?: "",
        parcel.readByte() != 0.toByte()
    )

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeInt(id)
        parcel.writeString(login)
        parcel.writeString(avatar_url)
        parcel.writeInt(score)
        parcel.writeString(html_url)
        parcel.writeByte(if (followState) 1 else 0)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<UserItem> {
        override fun createFromParcel(parcel: Parcel): UserItem {
            return UserItem(parcel)
        }

        override fun newArray(size: Int): Array<UserItem?> {
            return arrayOfNulls(size)
        }
    }
}