//
//  UIAlertController+extensions.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showAlert(_ title: String?, _ message: String?, _ cancelTitle: String?, _ fromController: UIViewController?) {
        let alertController: UIAlertController = .init(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = .init(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        fromController?.present(alertController, animated: true, completion: nil)
    }
}
