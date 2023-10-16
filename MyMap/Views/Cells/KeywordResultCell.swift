//
//  KeywordResultCell.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import UIKit

class KeywordResultCell: UITableViewCell {

    var keywordResult: KeywordResult? {
        didSet {
            setupData()
        }
    }
    
    private let placeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    private let distanceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private let addressLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [distanceLabel, lineView, addressLabel])
        stackView.spacing = 5
        return stackView
    }()
    
    private let phoneLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexCode: Color.blueColor)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [centerStackView, phoneLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
       
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupData(){
        guard let keywordResult = keywordResult else { return }
        
        placeNameLabel.text = keywordResult.placeName
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
        phoneLabel.text = keywordResult.phone
    }
    

    private func addViews(){
        self.contentView.addSubview(mainStackView)
    }
    
    private func setConstraints(){
        
        categoryNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        placeNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addressLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        distanceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}
