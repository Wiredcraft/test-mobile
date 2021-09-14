package com.example.testmobile

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.testmobile.model.GithubUser
import com.example.testmobile.model.SearchUserResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(private val repository: ApiRepository) : ViewModel() {

    val refreshUsers = MutableLiveData(mutableListOf<GithubUser>())
    val appendUsers = MutableLiveData(mutableListOf<GithubUser>())
    private val currentPage = MutableLiveData(1)
    val searchText = MutableLiveData("")

    val refreshLoading = MutableLiveData(false)

    /**
     * Method for init/refresh
     */
    fun initHomePageData() {
        refreshLoading.value = true
        // Reset page to 1
        currentPage.value = 1
        // Use 'swift' for default q, to avoid api error
        val q = if (searchText.value?.isNotEmpty() == true) searchText.value else "swift"

        repository.searchUsers(
            q.orEmpty(),
            1,
            object : ApiRepository.ApiCallback<SearchUserResponse> {
                override fun onSuccess(response: SearchUserResponse) {
                    refreshLoading.value = false
                    val newList = mutableListOf<GithubUser>()
                    newList.addAll(response.items ?: emptyList())
                    // Set response into refresh users
                    refreshUsers.value = newList
                }

                override fun onError(t: Throwable?) {
                    refreshLoading.value = false
                }
            })
    }

    /**
     * Load more users
     */
    fun loadMore() {
        val oldPage = currentPage.value ?: 1
        currentPage.value = oldPage + 1
        // Use 'swift' for default q, to avoid api error
        val q = if (searchText.value?.isNotEmpty() == true) searchText.value else "swift"

        repository.searchUsers(
            q.orEmpty(),
            oldPage + 1,
            object : ApiRepository.ApiCallback<SearchUserResponse> {
                override fun onSuccess(response: SearchUserResponse) {
                    val newList = mutableListOf<GithubUser>()
                    newList.addAll(response.items ?: emptyList())
                    // Set response into append users
                    appendUsers.value = newList
                }

                override fun onError(t: Throwable?) {
                }
            })
    }

}