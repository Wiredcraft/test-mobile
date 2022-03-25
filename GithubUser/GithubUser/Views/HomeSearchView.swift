//
//  HomeSearchView.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/24.
//

import UIKit
import SnapKit

public protocol SearchViewDelegate : NSObjectProtocol {
    func searchViewShouldReturn(_ textField: UITextField) -> Bool
}
extension SearchViewDelegate {
    //点击键盘返回
    func searchViewShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
}
class HomeSearchView: UIView {
    
    lazy var searchTextField: UITextField = {
        var searchTextField = UITextField.init()
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
        searchTextField.returnKeyType = .search
        searchTextField.placeholder = "UserName"
        searchTextField.font = .systemFont(ofSize: 13)
        searchTextField.backgroundColor = .init(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = 20
        searchTextField.delegate = self
        return searchTextField
    }()
    public weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initSubViews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        initSearchTextField()
    }
    
    func initSearchTextField ()  {
        // rightView
        let imgView = UIImageView.init(image: .init(named: "search"))
        imgView.sizeToFit()
        let rightView = UIView.init(frame: .init(x: 0,
                                                 y: 0,
                                                 width: imgView.frame.size.width + 15,
                                                 height: imgView.frame.size.height))
        rightView.addSubview(imgView)
        searchTextField.rightView = rightView
        
        // leftView
        let leftView = UIView.init(frame: .init(x: 0, y: 0, width: 15, height: 0))
        searchTextField.leftView = leftView
      
        self.addSubview(searchTextField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchTextField.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}

extension HomeSearchView: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard (delegate?.searchViewShouldReturn(textField)) != nil else {
            // optional not implemented
            return false
        }
        return ((delegate?.searchViewShouldReturn(textField)) != nil)
    }
}
