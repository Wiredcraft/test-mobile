//
//  Utility.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/27.
//
import Foundation



func formattedScoreString(score: Float) -> String {
  let formatter = NumberFormatter()
  formatter.minimumFractionDigits = 0
  formatter.maximumFractionDigits = 2
  formatter.minimumIntegerDigits = 1
  return formatter.string(from: NSNumber(value: score))!
}

func calculateIndexPathsToAdd(userArray: UserArray, page: Int) -> [IndexPath] {
  let startIndex = (page - 1) * 30
  let endIndex = startIndex + userArray.users.count % 30 == 0 ? 30 : userArray.users.count
  return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
}
