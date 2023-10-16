//
//  KeywordCell.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    var keyword: Keyword? {
        didSet {
            guard let keyword = keyword else { return }
            mainImageView.image = keyword.image
            keywordLabel.text = keyword.keyword
            
            DispatchQueue.main.async {
                self.keywordLabel.sizeToFit()
                self.mainView.layer.cornerRadius = self.mainView.frame.size.height / 2
            }
        }
    }
    
    var isBorderUse: Bool? {
        didSet {
            guard let isBorderUse = isBorderUse else { return }
            if isBorderUse  {
                mainView.backgroundColor = .white
                mainView.clipsToBounds = true
                mainView.layer.borderColor = UIColor(hexCode: Color.grayColor).cgColor
                mainView.layer.borderWidth = 0.5
                mainView.layer.shadowColor = UIColor.gray.cgColor
                mainView.layer.shadowOpacity = 0.3
                mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
                mainView.layer.masksToBounds = false
            }
        }
    }
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let keywordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainImageView, keywordLabel])
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.addSubview(mainStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addViews(){
        self.contentView.addSubview(mainView)
    }
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 15),
            mainImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
