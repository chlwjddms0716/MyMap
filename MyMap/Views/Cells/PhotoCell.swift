//
//  PhotoCell.swift
//  MyMap
//
//  Created by 최정은 on 10/11/23.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var imageURL: String?  {
        didSet{
            loadImage()
        }
    }
    
  private  let imageView: UIImageView = {
      let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
    private func addViews(){
        self.contentView.addSubview(imageView)
    }
    
    private func setConstrains(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func loadImage(){
        if var imageURL = imageURL {
            
            if imageURL.contains("postfiles.pstatic") {
               imageURL = imageURL.replacingOccurrences(of: "jpg?", with: "jp")
            }
            
            UIImage().loadImage(imageUrl: imageURL, isReviewImage: true) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
