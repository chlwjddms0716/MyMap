//
//  PhotoListView.swift
//  MyMap
//
//  Created by 최정은 on 10/11/23.
//

import UIKit

class PhotoListView: UIView {

    
    private var photoArray: [PhotoListList] = []
    
    private lazy var heightConstrains = collectionView.heightAnchor.constraint(equalToConstant: size * 2 + 1)
   private let layout = UICollectionViewFlowLayout()
   private lazy var size = (UIScreen.main.bounds.width - 32) / 3
    
    private lazy var collectionView: UICollectionView = {
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: size, height: size)
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    init(photoList: [PhotoListList]) {
        super.init(frame: .zero)
        
        addViews()
        setConstraints()
        setupCollectionView()
        configureUI()
        
        photoArray = photoList
        setupDatas()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    private func addViews(){
        self.addSubview(collectionView)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            heightConstrains
        ])
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Cell.PhotoCellIdentifier)
    }
    
    private func setupDatas(){
        if self.photoArray.count > 3 {
            self.heightConstrains.constant = size * 2 + 1
        }
        else {
            self.heightConstrains.constant = size
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension PhotoListView:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.PhotoCellIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.imageURL = photoArray[indexPath.row].orgurl
       
        return cell
    }
}
