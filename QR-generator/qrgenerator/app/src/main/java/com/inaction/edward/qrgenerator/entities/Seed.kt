package com.inaction.edward.qrgenerator.entities

import android.arch.persistence.room.Entity
import android.arch.persistence.room.PrimaryKey
import android.os.Parcel
import android.os.Parcelable

@Entity(tableName = "seed")
data class Seed(var data: String, var expiredAt: Long): Parcelable {

    constructor(): this("", 0)

    @PrimaryKey(autoGenerate = true)
    var id: Long = 0

    var type: Int = 0 // 0: generated, 1: scanned

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
