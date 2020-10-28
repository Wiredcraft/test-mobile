//
//  NoResultCell.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/26.
//

import UIKit

class NoResultCell: UITableViewCell {
  
  lazy var noResultLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .center
    label.text = "No Result"
    label.textColor = .systemGray
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    contentView.addSubview(noResultLabel)
    noResultLabel.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
