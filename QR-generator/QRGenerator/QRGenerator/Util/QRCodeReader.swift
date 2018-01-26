//
//  QRCodeReader.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit

public class QRCodeReader {
    private var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    public func read() -> String? {
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        guard let features = image.ciImage.flatMap({ detector?.features(in: $0) }) as? [CIQRCodeFeature] else {
            return nil
        }
        
        return features.flatMap { $0.messageString }.reduce(String()) { $0 + $1 }
    }
}
