//
//  GDHomeCell.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class GULUsersListCell: UITableViewCell {
    private lazy var disposeBag = DisposeBag()
    
    private lazy var icon : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 4.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private lazy var scoreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var htmlUrlLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18.0)
            make.top.equalToSuperview().offset(10.0)
            make.width.height.equalTo(60.0)
        }
        
        contentView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-18.0)
            make.top.equalToSuperview().offset(10.0)
            make.height.equalTo(30.0)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.right.equalTo(scoreLabel.snp.left).offset(-5)
            make.top.height.equalTo(scoreLabel)
            make.width.lessThanOrEqualTo(100.0)
        }
        
        contentView.addSubview(htmlUrlLabel)
        htmlUrlLabel.snp.makeConstraints { [unowned self] (make) in
            make.bottom.equalToSuperview().offset(-10.0)
            make.right.equalTo(scoreLabel)
            make.top.equalTo(scoreLabel.snp.bottom).offset(10.0)
        }
    }
    
    func bind(viewModel: GULUserItemViewModel) {
        viewModel.name.asDriver().drive(nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.score.asDriver().map({ "\($0 ?? 0)" }).drive(scoreLabel.rx.text).disposed(by: disposeBag)
        viewModel.score.asDriver().map({ $0 == nil }).drive(scoreLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.htmlUrl.asDriver().drive(htmlUrlLabel.rx.text).disposed(by: disposeBag)
        viewModel.icon.asDriver().drive(onNext: { [weak self] (iconUrl) in
            guard let tempUrl = iconUrl else {
                return
            }
            self?.icon.kf.setImage(with: URL(string: tempUrl))
        }).disposed(by: disposeBag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
