//
//  BlogReviewView.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit

class BlogReviewView: UIView {

    private var CELL_SIZE: CGFloat = 235
    private var VIEW_SIZE: CGFloat = 1000
    private var cellNum = 3
    private var blogReview: [BlogReviewList] = []
    private var isShowAll: Bool = false
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "리뷰"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
   private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("리뷰 더보기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        
        button.contentMode = .scaleToFill
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 2)
        button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    init(blogReview: [BlogReviewList], isShowAll: Bool = false){
        super.init(frame: .zero)
        
        self.blogReview = blogReview
        
        self.isShowAll = isShowAll
        if isShowAll {
            cellNum = blogReview.count
            tableView.isScrollEnabled = true
        }
        else {
            cellNum = blogReview.count > 3 ? 3 : blogReview.count
        }
        
        VIEW_SIZE = CELL_SIZE * Double(cellNum)
        
        configureUI()
        addViews()
        setConstraints()
        setupTableView()
        setupDatas()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    
    private func addViews(){
        self.addSubview(titleStackView)
        self.addSubview(tableView)
        if !isShowAll {
            self.addSubview(moreButton)
        }
    }
    
    
    private func setConstraints(){
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        countLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: VIEW_SIZE)
        ])
        
        if !isShowAll {
            NSLayoutConstraint.activate([
                moreButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
                moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            ])
        }else {
            NSLayoutConstraint.activate([
                tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                titleStackView.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = CELL_SIZE
        tableView.register(BlogReviewCell.self, forCellReuseIdentifier: Cell.BlogReviewCellIdentifier)
    }
    
    private func setupDatas(){
        
        countLabel.text = String( blogReview.count )
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func moreButtonTapped(){
        NotificationCenter.default.post(name: Notification.Name.reviewMore, object: nil)
    }
}

extension BlogReviewView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.BlogReviewCellIdentifier, for: indexPath) as? BlogReviewCell else { return UITableViewCell() }
        
        cell.review = blogReview[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let blogURL = blogReview[indexPath.row].outlink else { return }
        
        let dataToSend: [String: Any] = ["url": blogURL]
        NotificationCenter.default.post(name: Notification.Name.blogWebView, object: nil, userInfo: dataToSend)
    }
}

