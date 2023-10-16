//
//  CarouselView.swift
//  MyMap
//
//  Created by 최정은 on 10/11/23.
//

import UIKit

class CarouselView: UIView {

    private var imageList: [String] = []
    
    lazy var cellSize = CGSize(width: (UIScreen.main.bounds.width - 30), height: 200)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
       layout.itemSize = cellSize
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let countTextView: UITextView = {
       let textView = UITextView()
        textView.clipsToBounds = true
        //textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = .white
        textView.backgroundColor  = .black.withAlphaComponent(0.4)
        textView.layer.cornerRadius = 12.5
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return textView
    }()
        
    init(imageList: [String]){
        super.init(frame: .zero)
        
        setupCollectionView()
        addViews()
        setConstraints()
        
        self.imageList = imageList
        
      
        DispatchQueue.main.async{
            self.collectionView.reloadData()
            
            self.countTextView.text = "1 / \(self.imageList.count)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews(){
        self.addSubview(collectionView)
        self.addSubview(countTextView)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Cell.PhotoCellIdentifier)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant:  200)
        ])
        
        NSLayoutConstraint.activate([
        
            countTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            countTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            countTextView.widthAnchor.constraint(equalToConstant: 45),
            countTextView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

private var lastContentOffset: Double = 0.0
private var currentPage = 0

extension CarouselView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.PhotoCellIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell()}
        
        cell.imageURL = imageList[indexPath.row]
        return cell
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
       let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
       let cellWidth = cellSize.width
       let index = round(scrolledOffsetX / cellWidth)
       targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        DispatchQueue.main.async {
            self.countTextView.text = "\(Int(index) + 1) / \(self.imageList.count)"
        }
     }
}
