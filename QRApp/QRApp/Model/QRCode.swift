//
//  QRCode.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit

/// Class which generates QR codes from UTF-8 endoded Strings or Data
///
class QRCode {
    
    private let text: String?
    private let data: Data
    private let qrImage: CIImage
    
    public init?(text: String) {
        self.text = text
        guard let data = text.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        self.data = data
        guard let image = QRCode.createQRImage(data) else {
            return nil
        }
        self.qrImage = image
    }
    
    public init?(data: Data) {
        self.text = nil
        self.data = data
        guard let image = QRCode.createQRImage(data) else {
            return nil
        }
        self.qrImage = image
    }
    
    func asUIImage() -> UIImage {
        return UIImage(ciImage: qrImage)
    }
    
    func toString() -> String? {
        return text
    }
    
    func asUIImageScaledTo(size: Int) -> UIImage {
        let scaleX = size.asCGFloat() / qrImage.extent.size.width
        let scaleY = size.asCGFloat() / qrImage.extent.size.height
        let transformedImage = qrImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        return UIImage(ciImage: transformedImage)
    }
    
    private class func createQRImage(_ data: Data) -> CIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        guard let qrImage = filter?.outputImage else { return nil }
        return qrImage
    }
}
