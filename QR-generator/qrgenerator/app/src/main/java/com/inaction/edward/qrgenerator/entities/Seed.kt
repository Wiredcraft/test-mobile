package com.inaction.edward.qrgenerator.entities

import android.os.Parcel
import android.os.Parcelable

data class Seed(val data: String, val expiredAt: Long): Parcelable {

    private constructor(parcel: Parcel): this(parcel.readString(), parcel.readLong())

    companion object {
        @JvmField
        val CREATOR = object: Parcelable.Creator<Seed> {
            override fun createFromParcel(parcel: Parcel): Seed {
                return Seed(parcel)
            }

            override fun newArray(size: Int): Array<Seed?> {
                return arrayOfNulls(size)
            }

        }
    }

    override fun writeToParcel(parcel: Parcel?, flag: Int) {
        parcel?.writeString(data)
        parcel?.writeLong(expiredAt)
    }

    override fun describeContents(): Int {
        return 0
    }

}
