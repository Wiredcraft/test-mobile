//
//  UserlistCell.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import UIKit

class UserlistCell: UITableViewCell {
    var downloadImageTask: URLSessionDownloadTask?
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        urlLabel.textColor = UIColor.black
        downloadImageTask?.cancel()
        downloadImageTask = nil
    }
    
    /// override Cell Frame
    override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            frame.origin.x += 10
            frame.origin.y += 10
            frame.size.height -= 10
            frame.size.width -= 20
            super.frame = frame
        }
    }
    // MARK: - Initialize
    func initialize() {
        self.backgroundColor = UIColor.secondarySystemBackground
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        avatorImageView.layer.masksToBounds = true
        avatorImageView.layer.cornerRadius = avatorImageView.frame.width / 2
        nameLabel.preferredMaxLayoutWidth = 80
        nameLabel.numberOfLines = 0
    }
    // MARK: - Setrting Data
    func prepareData(for result: Item) {
        if let login = result.login {
            nameLabel.text = login
        }
        if let score = result.score {
            scoreLabel.text = String(format: "%.2f", score)
        }
        if let htmlUrl = result.html_url {
            urlLabel.text = htmlUrl
        }
        if let avatorURL = result.avatar_url {
            downloadImageTask = avatorImageView.loadImage(urlString: avatorURL)
        }
        if result.isLoaded ?? false {
            urlLabel.textColor = UIColor.blue
        }
    }
}

