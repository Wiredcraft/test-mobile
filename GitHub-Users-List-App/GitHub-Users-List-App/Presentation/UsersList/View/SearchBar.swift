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
        textField.delegate = self
        textField.returnKeyType = .done
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

    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.isHidden = true
        return button
    }()

    lazy var cleanButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cleanButtonAction(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(UIColor(red: 0.749, green: 0.749, blue: 0.749, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.isHidden = true
        return button
    }()
    var searchText = Observable("")

    var editing: Bool = false {
        didSet {
            if editing {
                setupEditing()
            } else {
                setupNormal()
            }
        }
    }
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
        self.backgroundColor = .systemBackground
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(magnifier)
        containerView.addSubview(cleanButton)
        addSubview(cancelButton)
    }

    private func setupStyle() {
        let horizonMargin: CGFloat = 15
        let accessoryButtonWidth: CGFloat = 13
        let horizonGap: CGFloat = 5
        let textfieldRightInset: CGFloat = horizonMargin + accessoryButtonWidth * 2 + horizonGap * 2
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: horizonMargin, bottom: 3, right: textfieldRightInset))
        }
        magnifier.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(accessoryButtonWidth)
            make.right.equalToSuperview().offset(-horizonMargin)
        }
        cleanButton.snp.makeConstraints { make in
            make.right.equalTo(magnifier.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(accessoryButtonWidth)
        }
    }

    private func setupEditing() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.cancelButton.isHidden = false
            self.cleanButton.isHidden = false
            self.cancelButton.snp.remakeConstraints({ make in
                make.right.equalTo(-10)
                make.centerY.equalTo(self.containerView)
                make.width.equalTo(60)
            })
            self.containerView.snp.remakeConstraints({ make in
                make.left.equalTo(20)
                make.right.equalTo(self.cancelButton.snp.left).offset(-5)
                make.bottom.equalTo(-10)
                make.height.equalTo(30)
            })
        }
    }

    private func setupNormal() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.cancelButton.isHidden = true
            self.cleanButton.isHidden = true
            self.containerView.snp.remakeConstraints { make in
                make.bottom.equalTo(-10)
                make.height.equalTo(30)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().offset(-40)
            }
        }
    }
}
// MARK: - TextField Delegate
extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editing = true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        editing = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
// MARK: - Action
extension SearchBar {
    @objc func textFieldDidChange() {
        if let text = textField.text {
            searchText.value = text
        }
    }

    @objc func cancelButtonAction(_ sender: UIButton) {
        guard !searchText.value.isEmpty else {
            textField.resignFirstResponder()
            return
        }
        textField.text = ""
        searchText.value = ""
        textField.resignFirstResponder()
    }

    @objc func cleanButtonAction(_ sender: UIButton) {
        guard !searchText.value.isEmpty else {
            return
        }
        textField.text = ""
        searchText.value = ""
    }
}
