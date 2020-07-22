//
//  UserCell.swift
//  GithubUsers
//
//  Created by Apple on 2020/7/20.
//

import UIKit

class UserCell: UITableViewCell {

    lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
