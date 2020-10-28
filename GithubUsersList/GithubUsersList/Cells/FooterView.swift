//
//  FooterView.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/28.
//

import UIKit

enum FooterViewState {
  case loading
  case hiding
  case noMoreResults
}

class FooterView: UIView {
  
  var currentState: FooterViewState = .hiding {
    didSet {
      updateViewByCurrentState()
    }
  }

  lazy var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.sizeToFit()
    indicator.startAnimating()
    return indicator
  }()
  
  lazy var noResultLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .center
    label.text = "No More Results"
    label.textColor = .systemGray
    label.sizeToFit()
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.addSubview(indicator)
    indicator.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    self.addSubview(noResultLabel)
    noResultLabel.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    updateViewByCurrentState()
  }
  
  
  
  
  
  func updateViewByCurrentState() {
    switch currentState {
    case .hiding:
      indicator.isHidden = true
      noResultLabel.isHidden = true
    case .loading:
      indicator.isHidden = false
      noResultLabel.isHidden = true
    case .noMoreResults:
      indicator.isHidden = true
      noResultLabel.isHidden = false
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
