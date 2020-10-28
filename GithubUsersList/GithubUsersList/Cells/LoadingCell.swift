//
//  LoadingCell.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/27.
//

import UIKit

class LoadingCell: UITableViewCell {
  
  lazy var loadingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .center
    label.text = "Loading..."
    label.textColor = .systemGray
    label.sizeToFit()
    return label
  }()
  
  lazy var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.sizeToFit()
    return indicator
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.addArrangedSubview(loadingLabel)
    stackView.addArrangedSubview(indicator)
    return stackView
  }()
  
  

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.width.equalTo(loadingLabel.bounds.width + indicator.bounds.height + 8)
      make.height.equalTo(60)
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
