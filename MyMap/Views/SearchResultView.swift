//
//  SearchResultView.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import UIKit

class SearchResultView: UIView {

    private let BOTTOM_VIEW_HEIGHT: CGFloat = 180
    private let BLANK_HEIGHT: CGFloat = 50
    private lazy var VIEW_HEIGHT: CGFloat = UIScreen.main.bounds.height + BLANK_HEIGHT
    
    private var isPageUp: Bool = false
    
    lazy var mapView: MTMapView = {
        let mapView = MTMapView(frame: self.bounds)
        mapView.baseMapType = .standard
        return mapView
    }()
    
    let keywordLabel: PaddingLabel = {
       let label = PaddingLabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.isUserInteractionEnabled = true       
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeChangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "map.fill")?.withTintColor( UIColor(hexCode: Color.pointColor), renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
                    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16)
                    button.configuration = config
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "지도"
        label.textColor = UIColor(hexCode: Color.pointColor)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    
    lazy var typeStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [typeChangeButton, typeLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled  = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
                    config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16)
                    button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [typeStackView, keywordLabel, closeButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        var config = UIButton.Configuration.plain()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            return outgoing
        }
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 8)
        button.configuration = config
        button.setTitle("거리순", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.addSubview(topStackView)
        view.addSubview(sortButton)
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    let storeView: StoreView = {
        let storeView = StoreView()
        storeView.translatesAutoresizingMaskIntoConstraints = false
        return storeView
    }()
    
    let currentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "currenButtonIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var heightConstraint = storeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: VIEW_HEIGHT - BOTTOM_VIEW_HEIGHT)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
        setupScrollView()
        
        print("처음", storeView.scrollView.contentOffset.y)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private   func addViews(){
        self.addSubview(mapView)
        self.addSubview(topView)
        self.addSubview(lineView)
        self.addSubview(storeView)
        self.addSubview(currentButton)
        self.addSubview(tableView)
    }
    
    private func setConstraints(){
        let statusHeight = UIApplication.shared.statusBarFrame.size.height
       // heightConstraint.constant = 400
        
        NSLayoutConstraint.activate([
            currentButton.bottomAnchor.constraint(equalTo: storeView.topAnchor, constant: -20),
            currentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            currentButton.widthAnchor.constraint(equalToConstant: 50),
            currentButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            typeStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
            topStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            topStackView.topAnchor.constraint(equalTo: topView.topAnchor, constant: statusHeight + 10),
            topStackView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 0),
            sortButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            sortButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5),
            //sortButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -1),
            lineView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heightConstraint,
            storeView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height + BLANK_HEIGHT),
            storeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            storeView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupScrollView(){
        storeView.scrollView.delegate = self
    }

 
    func downPage(){
        storeView.scrollView.isScrollEnabled = false
        heightConstraint.constant = VIEW_HEIGHT - BOTTOM_VIEW_HEIGHT
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            
            self.storeView.topView.alpha = 0
        } completion: { result in
            if self.heightConstraint.constant != 0 {
                self.storeView.topView.isHidden = true
            }
            
            let desiredOffset = CGPoint(x: 0, y: 0)
            self.storeView.scrollView.setContentOffset(desiredOffset, animated: false)
            
            self.isPageUp = false
            
            DispatchQueue.main.async {
                self.storeView.removeDetail()
            }
        }
    }
    
    func upPage(){
        storeView.scrollView.isScrollEnabled = true
        heightConstraint.constant = 0
        
        storeView.topView.alpha = 0
        storeView.topView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            
            self.storeView.topView.alpha = 1
        } completion: { result in
            
            let desiredOffset = CGPoint(x: 0, y: 8)
            self.storeView.scrollView.setContentOffset(desiredOffset, animated: false)
        }
    }
    
    func setScroll(){
        let desiredOffset = CGPoint(x: 0, y: 8)
        self.storeView.scrollView.setContentOffset(desiredOffset, animated: false)
      
        self.isPageUp = true
    }
}

extension SearchResultView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        
        if currentOffsetY <= 8  && isPageUp  {
            downPage()
        }
    }
}
