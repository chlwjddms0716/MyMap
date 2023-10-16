//
//  MyView.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class MyView: UIView {

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(hexCode: Color.grayColor).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let userNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(hexCode: Color.grayColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var userStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [userImageView, userNameLabel, logoutButton])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let logButton: UIButton = {
        let button = UIButton()
        button.setTitle("마이로그", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "clock.arrow.circlepath")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("후기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "star")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private let bookMarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("즐겨찾기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "star")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private let suggestButton: UIButton = {
        let button = UIButton()
        button.setTitle("장소제안", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logButton, reviewButton, bookMarkButton, suggestButton])
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(hexCode: Color.lightGrayColor)
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 5
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
    
    private  func configureUI(){
        self.backgroundColor = .white
    }
    
    private  func addViews(){
        self.addSubview(userStackView)
        self.addSubview(mainStackView)
    }
    
    private  func setConstraints(){
        NSLayoutConstraint.activate([
            userStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            userStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            userStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            userStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: userStackView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: userStackView.trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            logoutButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
