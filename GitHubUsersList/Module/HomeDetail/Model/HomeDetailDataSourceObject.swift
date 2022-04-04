//
//  HomeDetailDataSourceObject.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/4/4.
//

import UIKit

class HomeDetailDataSourceObject: NSObject, QMUITableViewDataSource{
    
    weak var modelManager : HomeDetailViewModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.modelManager?.userModelFrames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: 对需要引入具体Cell类型感到不适，未处理
        let homeUserModelFrame = self.modelManager?.userModelFrames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: homeUserModelFrame?.identifier ?? "", for: indexPath)
        let tempCell = cell as! HomeTabelViewCell
        
        tempCell.iconIV.sd_internalSetImage(with:  URL.init(string: homeUserModelFrame?.model?.avatarURLStr ?? ""), placeholderImage: UIImage.init(named: "Home_chartlet_user_default"), options: SDWebImageOptions.retryFailed, context: nil, setImageBlock: { image, data, sDImageCacheType, url in},
                                            progress: nil,
                                            completed: { image, data, error, sdImageCacheType, isFinished, url in
            
            if image != nil{
                
                DispatchQueue.global().async {
                    
                    var tempImage : UIImage?
                    var temp = 0
                    
                    if (image != nil){
                        
                        if (Int(image!.size.width) > Int(image!.size.height)){
                            temp = Int(image!.size.height)
                        }else{
                            temp = Int(image!.size.width)
                        }
                    }
                    tempImage = image?.sd_resizedImage(with: CGSize(width: temp, height: temp), scaleMode: SDImageScaleMode.aspectFill)
                    tempImage = UIImage.circularClipImage(image: tempImage!)
                    DispatchQueue.main.async{
                        
                        tempCell.iconIV.image = tempImage
                    }
                }
            }
        })
        tempCell.tag = indexPath.row
        tempCell.nameLabel.text = homeUserModelFrame?.model?.name
        tempCell.scoreLabel.text = homeUserModelFrame?.model?.score
        tempCell.urlLabel.text = homeUserModelFrame?.model?.urlStr
        
        return cell
    }
}
