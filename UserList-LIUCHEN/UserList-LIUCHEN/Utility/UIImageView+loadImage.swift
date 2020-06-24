//
//  UIImageView+loadImage.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import UIKit

/// Can use Kingfisher instead
extension UIImageView {

    
    /// Download and Cache Image
    /// - Parameter urlString: Image url
    /// - Returns: URLSessionDownloadTask
    func loadImage(urlString: String) -> URLSessionDownloadTask{
        let session = URLSession.shared
        let imageCache = NSCache<AnyObject, UIImage>()
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = cacheImage
        }
        
        let url = URL(string: urlString)
        var downloadTask = URLSessionDownloadTask()
        if let url = url {
            downloadTask = session.downloadTask(with: url) { (url, response, error) in
                if let error = error {
                    print("Couldn't download image\(error)")
                    return
                }
                guard let url = url else { return }
                let data = try? Data(contentsOf: url)
                let image = UIImage(data: data!)
                imageCache.setObject(image!, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
