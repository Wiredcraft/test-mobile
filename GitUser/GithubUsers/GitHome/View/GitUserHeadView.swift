//
//  GitUserHeadView.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit

class GitUserHeadView: LZBaseView {

      var viewModel = GitUserViewModel()
      var textField = UITextField()
      override init(viewModel: LZBaseViewModel) {
          super.init(viewModel: viewModel)
          self.viewModel = viewModel as! GitUserViewModel
          setupUI()
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      
      //MARK: setupUI
      func setupUI()  {
        
        
        //创建输入框
        textField.borderStyle = .roundedRect
        addSubview(textField)
        textField.font = ktextFont(size: 14)
        textField.placeholder = "请输入用户名"
        textField.attributedPlaceholder = NSAttributedString.init(string:textField.placeholder ?? "", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14),NSAttributedString.Key.foregroundColor:ColorPlacrholder])
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30)
        }
        textField.returnKeyType = .search
        textField.delegate = self
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {[weak self] in
                if let weakSelf = self{
                    weakSelf.viewModel.searchName = $0
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
}


extension GitUserHeadView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        showLoading()
        self.viewModel.searchUser(search: textField.text ?? "", isFirst: true)
        return true
    }
}
