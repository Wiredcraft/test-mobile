//
//  QRCodeGenerator.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit

public class QRCodeGenerator {
    private var data: Data
    
    init(string: String) {
        self.data = string.data(using: .isoLatin1, allowLossyConversion: false)!
    }
    
    init(data: Data) {
        self.data = data
    }
    
    public func generate() -> UIImage? {
        let filter = CIFilter(name: "QRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        return filter?.outputImage.flatMap { UIImage(ciImage: $0) }
    }
}
