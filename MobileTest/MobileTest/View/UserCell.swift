//
//  UserCell.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit
import Kingfisher
import RxSwift
class UserCell: UITableViewCell {
    
    @IBOutlet public weak var avatorImageView: UIImageView!
    

    @IBOutlet public weak var userNameLabel: UILabel!
    @IBOutlet public weak var userScoreLabel: UILabel!
    @IBOutlet public weak var userURLabel: UILabel!
    
    @IBOutlet public weak var followButton: UIButton!
    
    public var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        avatorImageView.layer.cornerRadius = avatorImageView.frame.height / 2
        followButton.layer.cornerRadius = 4.0        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag = DisposeBag()
    }

}
