//
//  HistoryCell.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    var history: SearchHistory? {
        didSet {
            guard let history = history else { return }
            termLabel.text = history.term
        }
    }
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "historyIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let termLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(termLabel)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            mainImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            mainImageView.widthAnchor.constraint(equalToConstant: 30),
            mainImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            termLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            termLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            termLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 15),
            termLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10)
        ])
    }
}
