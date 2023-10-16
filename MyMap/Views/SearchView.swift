//
//  SearchView.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import UIKit

class SearchView: UIView {

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소,주소,버스 검색"
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        return textField
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 19)
            button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, searchTextField])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
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
    
    private let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .left
        label.text = "최근검색"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(hexCode: Color.grayColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("전체삭제", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [historyLabel, removeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    private  func configureUI(){
        self.backgroundColor = .white
    }
    
    private   func addViews(){
        self.addSubview(searchBarView)
        self.addSubview(collectionView)
        self.addSubview(lineView)
        self.addSubview(titleStackView)
        self.addSubview(tableView)
    }
    
    private  func setConstraints(){
        
        NSLayoutConstraint.activate([
            searchBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBarView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            searchStackView.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 10),
            searchStackView.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -10),
            searchStackView.topAnchor.constraint(equalTo: searchBarView.topAnchor, constant: 5),
            searchStackView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 25),
            //backButton.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            removeButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    
    }
}
