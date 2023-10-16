//
//  MainView.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class MainView: UIView {
    
    lazy var mapView: MTMapView = {
        let mapView = MTMapView(frame: self.bounds)
        mapView.baseMapType = .standard
        return mapView
    }()
    
    
    let currentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "currenButtonIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mapSettingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "mapSettingIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let myButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("마이", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alignTextBelow()
        return button
    }()
    
    let homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("홈", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "house")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.alignTextBelow()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("즐겨찾기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "bookmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        
        button.alignTextBelow()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [homeButton, bookmarkButton, myButton])
        stView.alignment = .fill
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.masksToBounds = false
        view.addSubview(stackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:  "line.3.horizontal")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchImageVIew, searchLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5
        view.addSubview(searchStackView)
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset  = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
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
        
        self.addSubview(mapView)
        self.addSubview(currentButton)
        self.addSubview(bottomView)
        self.addSubview(searchBarView)
        self.addSubview(collectionView)
        self.addSubview(mapSettingButton)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bottomView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            currentButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -20),
            currentButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            currentButton.widthAnchor.constraint(equalToConstant: 50),
            currentButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            searchBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBarView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            searchStackView.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -15),
            searchStackView.topAnchor.constraint(equalTo: searchBarView.topAnchor, constant: 10),
            searchStackView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            searchImageVIew.widthAnchor.constraint(equalToConstant: 22),
        
        ])
        
        NSLayoutConstraint.activate([
            mapSettingButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            mapSettingButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mapSettingButton.widthAnchor.constraint(equalToConstant: 40),
            mapSettingButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
