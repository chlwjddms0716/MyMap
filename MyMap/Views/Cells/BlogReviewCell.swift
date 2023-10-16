//
//  BlogReviewCell.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit

class BlogReviewCell: UITableViewCell {

    private let IMAGE_SIZE: CGFloat = 90
    
    var review: BlogReviewList? {
        didSet {
            setupDatas()
        }
    }
    
    private var imageList: [ListPhotoList] = []
    
    private let reviewTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, lineView, dateLabel])
        stackView.alignment = .center
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
       layout.itemSize = CGSize(width: IMAGE_SIZE + 20 , height: IMAGE_SIZE)
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIView()
         view.backgroundColor = .lightGray
        
       let stackView = UIStackView(arrangedSubviews: [reviewTitleLabel, reviewLabel, collectionView, userStackView, view])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addViews(){
        self.contentView.addSubview(mainStackView)
    }
    
    private func setConstraints(){
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: IMAGE_SIZE),
            
            lineView.topAnchor.constraint(equalTo: userStackView.topAnchor, constant: 2),
            lineView.bottomAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: -2),
            lineView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        NSLayoutConstraint.activate([
            reviewTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            reviewTitleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -15),
            reviewLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            userStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            userStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -15),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Cell.PhotoCellIdentifier)
    }
    
    private func setupDatas(){
        
        guard let review = review  else { return }
        
        reviewTitleLabel.text = review.title
        reviewLabel.text = review.contents
        
        if let photoList = review.photoList {
            imageList = photoList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        nameLabel.text = review.blogname
        dateLabel.text = review.date
    }
}

extension BlogReviewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.PhotoCellIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell()}
        
        cell.imageURL = imageList[indexPath.row].orgurl
        return cell
    }

}
