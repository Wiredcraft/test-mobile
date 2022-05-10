//
//  SearchBar.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import UIKit
import SnapKit

class SearchBar: UIView {
    // MARK: - Properties
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "search"
        textField.font = .systemFont(ofSize: 13)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    lazy var containerView: UIView =  {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    lazy var magnifier: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(red: 0.749, green: 0.749, blue: 0.749, alpha: 1), renderingMode: .alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     var searchText = Observable("")
    // MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupStyle()
    }

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(magnifier)
    }

    func setupStyle() {
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 39))
        }
        magnifier.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(13)
            make.right.equalToSuperview().offset(-19)
        }
    }
}
// MARK: - TextField Delegate
extension SearchBar: UITextFieldDelegate {

}
// MARK: - Action
extension SearchBar {
    @objc func textFieldDidChange() {
        if let text = textField.text {
            searchText.value = text
        }
    }
}
