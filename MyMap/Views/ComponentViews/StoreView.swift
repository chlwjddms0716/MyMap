//
//  StoreView.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import UIKit

class StoreView: UIView {

    var placeResult: TargetPlaceResult? {
        didSet {
           setupPlaceData()
        }
    }
    
    var keywordResult: KeywordResult? {
        didSet{
            setupData()
        }
    }
    
     lazy var topView: UIView = {
       let view = UIView()
         view.backgroundColor = .white
        view.isHidden = true
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
    
    let topButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [topButton, topPlaceNameLabel, blankView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
         scrollView.showsVerticalScrollIndicator = false
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    private let placeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let categoryNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [placeNameLabel, categoryNameLabel])
        stackView.spacing = 5
        return stackView
    }()
    
    private let addressLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var centerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [topStackView,addressLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "distanceIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [mainImageView, distanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [centerStackView, imageStackView])
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let callButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "square.and.arrow.up")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private let bookMarkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "bookmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.addSubview(bottomStackView)
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [callButton, shareButton, bookMarkButton])
        stackView.backgroundColor = .clear
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.spacing = 10
        st.backgroundColor = UIColor(hexCode: Color.grayColor)
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailPlaceView: DetailPlaceView = {
        let view = DetailPlaceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    private lazy var bottomSeparatorHeight = bottomSeparator.heightAnchor.constraint(equalToConstant: 10)
    private lazy var topSeparatorHeight = topSeparator.heightAnchor.constraint(equalToConstant: 10)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        configureUI()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.masksToBounds = false
    }
    
   
    func addViews(){
        
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(backView)
        scrollView.addSubview(detailPlaceView)
        scrollView.addSubview(topSeparator)
        scrollView.addSubview(stackView)
        scrollView.addSubview(bottomSeparator)
        
        self.addSubview(scrollView)
        self.addSubview(topView)
    }
    
    
    func setConstraints(){
        placeNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        categoryNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            detailPlaceView.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 20),
            detailPlaceView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailPlaceView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
        NSLayoutConstraint.activate([
            blankView.widthAnchor.constraint(equalToConstant: 40),
            topButton.widthAnchor.constraint(equalToConstant: 40)
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
            topView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            mainStackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 1, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 50),
            mainImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant:  40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 1),
            bottomStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 1),
            bottomStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -1),
            bottomStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: detailPlaceView.bottomAnchor, constant: 10),
            topSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topSeparator.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 1, constant: 0),
            topSeparatorHeight
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            bottomSeparator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            bottomSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomSeparator.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            bottomSeparator.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 1, constant: 0),
            bottomSeparatorHeight
        ])
    }
    
    private func setupData(){
        guard let keywordResult = keywordResult else { return }
        
        placeNameLabel.text = keywordResult.placeName
        topPlaceNameLabel.text = keywordResult.placeName
        categoryNameLabel.text = keywordResult.categoryGroupName
        if keywordResult.distance.count > 4, let distance = Double(keywordResult.distance) {
            distanceLabel.text = "\(distance / 1000)km"
        }
        else if keywordResult.distance.count > 0 {
            distanceLabel.text = "\(keywordResult.distance)m"
        }
        else{
            distanceLabel.text = ""
        }
        
        addressLabel.text = keywordResult.addressName
    }
    
    func removeDetail(){
       
        detailPlaceView.isHidden = true
        
        // stackView 비우기
        removeInStackView()
    }
    
    func setupPlaceData(){
      
        if let keywordResult = keywordResult, let placeResult = placeResult, let basicInfo = placeResult.basicInfo, let cid = basicInfo.cid {
            
            if keywordResult.id == String(cid) {
                
                detailPlaceView.isHidden = false
                // 상세정보
                detailPlaceView.placeResult = placeResult
                
                // 후기 사진들
                if let photoList = placeResult.photo?.photoList?.first,let photoArray = photoList.list  {
                    let photoListView = PhotoListView(photoList: photoArray)
                    stackView.addArrangedSubview(photoListView)
                }
                
                // 메뉴
                if let menuInfo = placeResult.menuInfo {
                    let menuView = MenuView(menuInfo: menuInfo)
                    stackView.addArrangedSubview(menuView)
                }
                
                if let coment = placeResult.comment , coment.list != nil {
                    let comentView = ComentView(coment: coment)
                    stackView.addArrangedSubview(comentView)
                }
                
                if let blogReview = placeResult.blogReview, let blogReviewList = blogReview.list {
                    let blogReviewView = BlogReviewView(blogReview: blogReviewList)
                    stackView.addArrangedSubview(blogReviewView)
                }
            }
        }
        
        // 구분선 높이 설정
        setSeparatorHeight()
    }
    
    
    private func removeInStackView() {
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
    
    private func setSeparatorHeight(){
        if stackView.subviews.count <= 0 {
            topSeparatorHeight.constant = 0
            bottomSeparatorHeight.constant = 0
        }else {
            topSeparatorHeight.constant = 10
            bottomSeparatorHeight.constant = 10
        }
        
        layoutIfNeeded()
    }
}


