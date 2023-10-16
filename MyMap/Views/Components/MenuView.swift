//
//  MenuView.swift
//  MyMap
//
//  Created by 최정은 on 10/11/23.
//

import UIKit

class MenuView: UIView {

    private var menuInfo: MenuInfo?
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "메뉴"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let menuImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(menuInfo: MenuInfo){
        super.init(frame: .zero)
        
        self.menuInfo = menuInfo
        
        configureUI()
        setupDatas()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    private func setupDatas(){
        guard let menuInfo = menuInfo else { return }
        
        self.addSubview(stackView)
        if let count = menuInfo.menucount {
            countLabel.text = String(count)
        }
        
        if let imageList = menuInfo.menuboardphotourlList {
            let carouselView = CarouselView(imageList: imageList)
            stackView.addArrangedSubview(carouselView)
            
        }
        
        if let menuList = menuInfo.menuList{
            for item in menuList {
                let menu =  MenuStackView(menu: item)
                stackView.addArrangedSubview(menu)
            }
        }
    }
    
    private func setConstraints(){
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        countLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
           menuImageView.heightAnchor.constraint(equalToConstant: 50),
            //menuImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
          //  stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}






class MenuStackView : UIStackView {
    
    private var menu: MenuList?
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(hexCode: Color.grayColor).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    init(menu: MenuList) {
        super.init(frame: .zero)
        
        self.menu = menu
        
        setupView()
        setConstrains()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        self.alignment = .top

        guard let menu = menu else { return }
        
        addArrangedSubview(nameLabel)
        nameLabel.text = menu.menu
        
        if let imageURL = menu.img {
         addArrangedSubview(imageView)
            UIImage().loadImage(imageUrl: imageURL, isReviewImage: true) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        else if let price = menu.price {
            addArrangedSubview(priceLabel)
            priceLabel.text = "\(price)원"
        }
    }
    
    private func setConstrains(){
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
