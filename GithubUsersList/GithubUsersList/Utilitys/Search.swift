//
//  Search.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/27.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class Search {
  
  enum State {
    case notSearchedYet
    case loading
    case loadingRefresh
    case loadingForNextPage
    case noResults
    case hasResults
  }
  private(set) var state: State = .notSearchedYet
  private(set) var userArray = UserArray()
  
  private var dataTask: URLSessionDataTask?
  
  private func searchURL(searchText: String, page: Int) -> URL {
    let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let urlString = String(format: "https://api.github.com/search/users?q=%@&page=%d", encodedText, page)
    let url = URL(string: urlString)
    return url!
  }
  
  func resetUserArray() {
    userArray = UserArray()
  }
  
  private func parse(data: Data) -> UserArray {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(UserArray.self, from: data)
      return result
    } catch {
      print("JSON Error: \(error)")
      return UserArray()
    }
  }

  func performSearch(for text: String, page: Int, refresh: Bool, completion: @escaping SearchComplete) {
    if !text.isEmpty {
      dataTask?.cancel()
      if page == 1 {
        state = refresh ? .loadingRefresh : .loading
      } else {
        state = .loadingForNextPage
      }
      
      let url = searchURL(searchText: text, page: page)
      let session = URLSession.shared
      dataTask = session.dataTask(with: url, completionHandler: {
        data, response, error in
        var newState = State.notSearchedYet
        var newUserArray = UserArray()
        var success = false
        if let error = error as NSError?, error.code == -999 {
          return
        }
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200, let data = data {
          newUserArray = self.parse(data: data)
          if newUserArray.users.isEmpty {
            newState = .noResults
          } else {
            newState = .hasResults
          }
          success = true
        }
        DispatchQueue.main.async {
          self.state = newState
          if page == 1 {
            self.userArray = newUserArray
          } else {
            self.userArray.total_count = newUserArray.total_count
            self.userArray.users += newUserArray.users
          }
          completion(success)
        }
      })
      dataTask?.resume()
    }
  }
  
  
  
  
  
  
}
