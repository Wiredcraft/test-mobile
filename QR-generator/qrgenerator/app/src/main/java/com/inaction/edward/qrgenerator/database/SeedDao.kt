package com.inaction.edward.qrgenerator.database

import android.arch.persistence.room.Dao
import android.arch.persistence.room.Insert
import android.arch.persistence.room.Query
import com.inaction.edward.qrgenerator.entities.Seed

@Dao
interface SeedDao {

    @Query("SELECT * FROM seed")
    fun getAll(): List<Seed>

    @Insert
    fun insert(seed: Seed)

}
