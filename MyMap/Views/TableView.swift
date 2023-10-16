//
//  TableView.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit

class TableView: UIView {

    lazy var topView: UIView = {
      let view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleStackView)
        view.addSubview(lineView)
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
   
   private let lineView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor(hexCode: Color.grayColor)
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
   
   private let blankView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
   
   private let topPlaceNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
   }()
   
   let closeButton: UIButton = {
      let button = UIButton()
       button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
       return button
   }()
   
   private lazy var titleStackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [closeButton, topPlaceNameLabel, blankView])
       stackView.translatesAutoresizingMaskIntoConstraints = false
       return stackView
   }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    private func setupNavigationBar(){
        
        self.addSubview(topView)
        
        NSLayoutConstraint.activate([
            blankView.widthAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            titleStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -1),
            lineView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
   
    func setupBlogReviewView(placeName: String?,  blogReview: [BlogReviewList]){
        topPlaceNameLabel.text = placeName
        
        let blogReviewView = BlogReviewView(blogReview: blogReview, isShowAll: true)
        blogReviewView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blogReviewView)
        
        NSLayoutConstraint.activate([
            blogReviewView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            blogReviewView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blogReviewView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blogReviewView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
