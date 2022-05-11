//
//  UserDetailSectionHeaderView.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import UIKit
import SnapKit
class UserDetailSectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: UITableViewHeaderFooterView.self)
    lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .dynamicBlack
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .dynamicBlack
        label.font = .systemFont(ofSize: 18)
        label.text = "repositories".uppercased()
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(lineView)
        addSubview(titleLabel)

        lineView.snp.makeConstraints { make in
            make.left.equalTo(19)
            make.height.equalTo(20)
            make.width.equalTo(2)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(9)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
    }
}
