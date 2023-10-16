//
//  MapSettingView.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class MapSettingView: UIView {
    
    let standardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "standardMapSelect")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let standardLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.textAlignment = .center
        label.text = "기본지도"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var standardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [standardImageView, standardLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let hybridImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hybridMap")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let hybridLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "지도+스카이뷰"
        return label
    }()
    
    lazy var hybridStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hybridImageView, hybridLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [standardStackView, hybridStackView])
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "지도설정"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.addSubview(mainLabel)
        self.addSubview(mainStackView)
    }
    
    private  func setConstraints(){
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor , constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
        
        standardLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
