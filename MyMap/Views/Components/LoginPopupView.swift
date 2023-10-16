//
//  LoginPopupView.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import UIKit

class LoginPopupView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     let closeButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .right
     
        return button
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationIcon")?.withTintColor(UIColor(hexCode: Color.blueColor), renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인을 하면 후기, 톡친구 위치공유 등\n더 많은 기능을 이용할 수 있습니다."
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 2
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
     let loginWithKaKaoButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = UIColor(hexCode: Color.yelloColor)
        button.setTitle("카카오계정으로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let loginButton: UIButton = {
        let button = UIButton()
        let attributedString = NSAttributedString(
            string: "직접 입력해서 로그인",
            attributes: [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: UIColor.gray // 밑줄 색상 지정
            ]
        )
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ imageView, guideLabel, loginWithKaKaoButton, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.addSubview(stackView)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private  func addViews(){
        self.addSubview(backView)
       
        self.addSubview(mainView)
        self.addSubview(closeButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 270),
            mainView.widthAnchor.constraint(equalToConstant: 270)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            closeButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // 270 - 30 - 90 - 50 - 40 - 60
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 90),
            guideLabel.heightAnchor.constraint(equalToConstant: 50),
            loginWithKaKaoButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
