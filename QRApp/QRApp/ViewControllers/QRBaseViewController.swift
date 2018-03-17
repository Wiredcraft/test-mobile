//
//  QRBaseViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 14/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// The abstract base class for view controllers in this app.
///
class QRBaseViewController: UIViewController {

    //let backend: Backend
    let http = HTTPService()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        asyncCalculation()
//            .displayErrorOnUI()
//            .onLoadingStateChange { isLoading in
//                print(isLoading)
//            }
//            .onSuccess { lol in
//                print(lol)
//            }
//            .onFailure { error in
//                print("virhe")
//            }
        http.jsonRequest(url: URL(string: "https://httpbin.org/delay/0")!).onSuccess { dict in
            print(dict)
        }
        
    }
    
    func asyncCalculation() -> AsyncOperation<String> {
        return AsyncOperation { complete in
            let url = URL(string: "https://httpbin.org/delay/5")
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let error = error else {
                    complete(.success("LOL"))
                    return
                }
                complete(.failure(error as NSError))
            }
            task.resume()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavBarAppearance()
    }
    
    private func updateNavBarAppearance() {
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        navBar.tintColor = .white
        navBar.barTintColor = .darkBlue
        navBar.isTranslucent = false
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
