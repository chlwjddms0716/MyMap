//
//  ComentCell.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit

class ComentCell: UITableViewCell {

    var comment: CommentList? {
        didSet {
            setupDatas()
        }
    }
    
    private lazy var heightConstraints = commentTextView.heightAnchor.constraint(equalToConstant: 0)
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentCountTextView: UITextView = {
       let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.lineFragmentPadding = 0;
        textView.textContainerInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.sizeToFit()
        return textView
    }()
    
    
    private let averageTextView: UITextView = {
       let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.lineFragmentPadding = 0;
        textView.textContainerInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [commentCountTextView, averageTextView, lineView, dateLabel])
        stackView.spacing = 3
        stackView.alignment = .center
        return stackView
    }()
    
    private let starView: JStarRatingView = {
        let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)), rating: 3.8, color: UIColor(hexCode: Color.redColor), starRounding: .floorToHalfStar)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        return starRatingView
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, infoStackView, starView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let commentTextView: UITextView = {
       let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textView.textContainerInset =  UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.backgroundColor = UIColor(hexCode: Color.pointColor, alpha: 0.1)
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 5
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
       addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews(){
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(userStackView)
        self.contentView.addSubview(commentTextView)
    }
    
    private func setConstraints(){
        
        commentCountTextView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        averageTextView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 30),
            userImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            userStackView.topAnchor.constraint(equalTo: userImageView.topAnchor),
            userStackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 10),
            commentTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
        ])
        
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 1),
            lineView.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -1),
            starView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupDatas(){
        guard let comment = comment else { return }
        
        UIImage().loadImage(imageUrl: comment.profile) { image in
            DispatchQueue.main.async {
                self.userImageView.image = image
            }
        }
        
        userNameLabel.text = comment.username
        
        if let reviewCount = comment.userCommentCount {
            let totalText = "후기 \(reviewCount)"
            let attributedText = NSMutableAttributedString(string: totalText)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .regular), range: (totalText as NSString).range(of: "후기"))
            attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: (totalText as NSString).range(of: "후기"))
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: (totalText as NSString).range(of: "\(reviewCount)"))
            attributedText.addAttribute(.foregroundColor, value: UIColor.darkGray, range: (totalText as NSString).range(of: "\(reviewCount)"))
            
            commentCountTextView.attributedText = attributedText
        }
        
        if let averageScore = comment.userCommentAverageScore {
            let totalText = "별점평균 \(averageScore)"
            let attributedText = NSMutableAttributedString(string: totalText)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .regular), range: (totalText as NSString).range(of: "별점평균"))
            attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: (totalText as NSString).range(of: "별점평균"))
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: (totalText as NSString).range(of: "\(averageScore)"))
            attributedText.addAttribute(.foregroundColor, value: UIColor.darkGray, range: (totalText as NSString).range(of: "\(averageScore)"))
            
            averageTextView.attributedText = attributedText
            
            starView.rating = Float(averageScore)
        }
        
        dateLabel.text = comment.date
        commentTextView.text = comment.contents
       
        if commentTextView.text == "" {
            print("홀리")
            heightConstraints.isActive = true
        }
        else {
            heightConstraints.isActive = false
        }
    }
}
