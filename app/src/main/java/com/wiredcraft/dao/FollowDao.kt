package com.wiredcraft.dao

import androidx.room.*
import com.wiredcraft.bean.FollowState

@Dao
interface FollowDao {
    @Query("SELECT * FROM FollowState")
    suspend fun getAll(): List<FollowState>

    @Query("SELECT * FROM FollowState WHERE id = :id")
    suspend fun findById(id: Int): FollowState?

    @Query("DELETE FROM FollowState WHERE id = :id")
    suspend fun deleteById(id: Int)

    @Update
    suspend fun update(followStates: FollowState)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(vararg followStates: FollowState)

    @Transaction
    suspend fun insertOrUpdate(followState: FollowState) {
        val temp = findById(followState.id)
        if (temp != null) {
            update(FollowState(followState.id, followState.state, temp.uid))
        } else {
            insertAll(followState)
        }
    }
}
