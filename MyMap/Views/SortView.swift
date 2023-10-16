//
//  SortView.swift
//  MyMap
//
//  Created by 최정은 on 10/10/23.
//

import UIKit

class SortView: UIView {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
                    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 19)
                    button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "정렬 옵션"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
      let accuracyButton: UIButton = {
        let button = UIButton()
        button.setTitle("정확도순", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
          button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
     let distanceButton: UIButton = {
        let button = UIButton()
        button.setTitle("거리순", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.clipsToBounds = true
         button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [accuracyButton, distanceButton])
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    private func addViews(){
        self.addSubview(closeButton)
        self.addSubview(titleLabel)
        self.addSubview(mainStackView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ])
    }

}
