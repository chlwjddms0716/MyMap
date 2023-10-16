//
//  UIImage+Extension.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import Foundation

extension UIImage {
    
    func loadImage(imageUrl: String?, isReviewImage: Bool = false, completion: @escaping (UIImage) -> Void ) {
        
        if let imgUrl = imageUrl, let url = URL(string: imgUrl){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if imgUrl == url.absoluteString  {
                        if let image = UIImage(data: data) {
                            completion(image)
                            return
                        }
                    }
                }
            }
        }
        
        if isReviewImage{
            completion(UIImage(named: "noImage")!)
        }
        else{
            completion(UIImage(named: "defaultProfile")!)
        }
    }
}
