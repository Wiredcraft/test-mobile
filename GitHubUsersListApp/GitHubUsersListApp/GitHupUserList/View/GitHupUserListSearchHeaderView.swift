//
//  GitHupUserListSearchHeaderView.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit

protocol GitHupUserListSearchHeaderViewDelegate: AnyObject {
    func searchFollowList(forKeyWorld: String)
}

class GitHupUserListSearchHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = GitHupUserListSearchHeaderViewID
    weak var delegate: GitHupUserListSearchHeaderViewDelegate?
    private var searchText: String = ""
    private lazy var searchView = {
        UIView().then {
            $0.backgroundColor = .white
        }
    }()
    private lazy var textField = {
        UITextField().then {
            $0.delegate = self
            $0.backgroundColor = UIColor(hex: "#F5F5F5")
            $0.placeholder  = "ESTHE"
            $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            $0.layer.cornerRadius  = 15
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumFontSize = 10
        }
    }()
    private lazy var iconImage = {
        UIImageView().then {
            $0.image = UIImage(named: listSearchIcon)
        }
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSubviews() {
        contentView.addSubview(searchView)
        searchView.addSubview(textField)
        searchView.addSubview(iconImage)
        searchView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        textField.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(30)
        }
        iconImage.snp.makeConstraints { maker in
            maker.width.equalTo(13)
            maker.height.equalTo(13)
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-40)
        }
        // placeholder position
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        textField.leftView = view
        textField.leftViewMode = .always
    }
    deinit {
        textField.resignFirstResponder()
    }
}

extension GitHupUserListSearchHeaderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchText = textField.text ?? ""
        delegate?.searchFollowList(forKeyWorld: searchText)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchText = textField.text ?? ""
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text ?? ""
        return textField.resignFirstResponder()
    }
}
