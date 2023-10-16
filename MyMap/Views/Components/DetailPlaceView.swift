//
//  DetailPlaceView.swift
//  MyMap
//
//  Created by 최정은 on 10/11/23.
//

import UIKit

class DetailPlaceView: UIView {
    
    private let FONT_SIZE: CGFloat = 14
    
    var placeResult: TargetPlaceResult? {
        didSet {
            setupDatas()
        }
    }

    private let addressTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset =  UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        return textView
    }()
    
    private let addressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailLocation")
        return imageView
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressImageView, addressTextView])
        stackView.spacing = 5
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.textContainerInset =  UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailClock")
        return imageView
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeImageView, timeTextView])
        stackView.spacing = 5
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var internetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FONT_SIZE)
        label.textColor = UIColor(hexCode: Color.blueColor)
        return label
    }()
    
    private let internetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailInternet")
        return imageView
    }()
    
    private lazy var internetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [internetImageView, internetLabel])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FONT_SIZE)
        label.textColor = UIColor(hexCode: Color.blueColor)
        return label
    }()
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailPhone")
        return imageView
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
        
        addressTextView.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func addViews(){
        self.addSubview(addressStackView)
        self.addSubview(timeStackView)
        self.addSubview(internetStackView)
        self.addSubview(phoneStackView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            addressStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            addressStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            addressStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: addressStackView.bottomAnchor, constant: 10),
            timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            internetStackView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 10),
            internetStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            internetStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            phoneStackView.topAnchor.constraint(equalTo: internetStackView.bottomAnchor, constant: 10),
            phoneStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            phoneStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            phoneStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            addressImageView.widthAnchor.constraint(equalToConstant: 20),
            addressImageView.heightAnchor.constraint(equalToConstant: 20),
            timeImageView.widthAnchor.constraint(equalToConstant: 20),
            timeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            internetImageView.widthAnchor.constraint(equalToConstant: 20),
            phoneImageView.widthAnchor.constraint(equalToConstant: 20),
            internetImageView.heightAnchor.constraint(equalToConstant: 20),
            phoneImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
  
    private func setupDatas(){
        

        guard let placeResult = placeResult, let basicInfo = placeResult.basicInfo else { return }
        
        if let address = basicInfo.address, let region = address.region {
            var newAddress = "\(region.newaddrfullname ?? "") \(address.newaddr?.newaddrfull ?? "") \(address.addrdetail ?? "")"
            if let newaddr = address.newaddr, let bsizonno = newaddr.bsizonno{
                newAddress += " (우)\(bsizonno)"
            }
            let oldAddress = "\(region.fullname ?? "") \(address.addrbunho ?? "")"
            let totalAdderss = "\(newAddress)\n\(oldAddress)"
            
            let addressAttributeStr = NSMutableAttributedString(string: totalAdderss)
            addressAttributeStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (totalAdderss as NSString).range(of: oldAddress))
            
            addressTextView.attributedText = addressAttributeStr
            addressTextView.font = UIFont.systemFont(ofSize: FONT_SIZE)
        }
        
        
        if let timeData = basicInfo.openHour {
            
            let openYN = timeData.realtime?.realtimeOpen == "Y"  ? "영업중" : "영업전"
            var timeStr = ""
            
            if let periodList = timeData.periodList, let first = periodList.first, let timeList = first.timeList {
                for time in timeList {
                    timeStr = timeStr == "" ? "\(time.dayOfWeek ?? "") \(time.timeSE ?? "")" : "\(timeStr)\n\(time.dayOfWeek ?? "") \(time.timeSE ?? "")"
                }
            }
            
            let totalTime = "\(openYN)\n\(timeStr)"
            
            timeTextView.textColor = .black
            
            let timeAttributeStr = NSMutableAttributedString(string: totalTime)
            timeAttributeStr.addAttribute(.foregroundColor, value: openYN == "영업중" ? UIColor(hexCode: Color.greenColor) : UIColor(hexCode: Color.redColor), range: (totalTime as NSString).range(of: openYN))
            timeAttributeStr.addAttribute(.font, value: UIFont.systemFont(ofSize: FONT_SIZE, weight: .bold), range: (totalTime as NSString).range(of: openYN))
            timeTextView.attributedText = timeAttributeStr
            timeAttributeStr.addAttribute(.font, value: UIFont.systemFont(ofSize: FONT_SIZE, weight: .regular), range: (totalTime as NSString).range(of: timeStr))
            timeTextView.attributedText = timeAttributeStr
        }
        else {
            timeTextView.text = "영업시간 추가"
            timeTextView.textColor = UIColor(hexCode: Color.pointColor)
        }
        
       
        if let homePage = basicInfo.homepage {
            internetLabel.text = homePage
        }
        else {
            internetLabel.text = "홈페이지 추가"
        }
 
        
        if let phoneNum = basicInfo.phonenum {
            phoneLabel.text = phoneNum
        }
        else {
            phoneLabel.text = "전화번호 추가"
        }
    }
}

extension DetailPlaceView : UITextViewDelegate {
   
    func textViewDidChange(_ textView: UITextView) {
        print(#function)
           let size = CGSize(width: self.frame.width, height: .infinity)
           let estimatedSize = textView.sizeThatFits(size)
           
           textView.constraints.forEach { (constraint) in
           
             
               if constraint.firstAttribute == .height {
                   constraint.constant = estimatedSize.height
               }
           }
       }
}
