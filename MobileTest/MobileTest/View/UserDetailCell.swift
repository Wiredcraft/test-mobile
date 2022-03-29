//
//  UserDetailCell.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/28.
//

import UIKit
import Kingfisher
import RxSwift
class UserDetailCell: UITableViewCell {
    
    @IBOutlet public weak var avatorImageView: UIImageView!
    
    @IBOutlet public weak var userNameLabel: UILabel!
    @IBOutlet public weak var userScoreLabel: UILabel!
    @IBOutlet public weak var userURLabel: UILabel!
    
    public var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatorImageView.layer.cornerRadius = avatorImageView.frame.height / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag = DisposeBag()
    }
}
