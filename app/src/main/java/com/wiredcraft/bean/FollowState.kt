package com.wiredcraft.bean

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class FollowState(
    @ColumnInfo(name = "id") val id: Int = 0,
    @ColumnInfo(name = "state") val state: Boolean = false,
    @PrimaryKey(autoGenerate = true) val uid: Int = 0,
)