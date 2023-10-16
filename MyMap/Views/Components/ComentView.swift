//
//  ComentView.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit


class ComentView: UIView {

    private let CELL_SIZE: CGFloat = 170
    private var VIEW_SIZE: CGFloat = 100
    
    private var comentList: [CommentList] = []
    
    private let scoreTextView: UITextView = {
      let label = UITextView()
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starView: JStarRatingView = {
        let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 150)), rating: 0, color: UIColor(hexCode: Color.redColor), starRounding: .floorToHalfStar)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        return starRatingView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: Color.grayColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(coment: Comment){
        super.init(frame: .zero)
        
        if let comentList = coment.list {
            self.comentList = comentList
            
            if let comentList = coment.list {
                VIEW_SIZE = comentList.count > 3 ? CELL_SIZE * Double(3) : CELL_SIZE * Double(comentList.count)
                
                var blankNum = 0
                for item in comentList {
                    if (item.contents == nil) || item.contents == "" {
                        blankNum += 1
                    }
                }
                
                VIEW_SIZE -=  CGFloat(Float(blankNum * 70))
            }
        }
        
        configureUI()
        addViews()
        setConstrains()
        setupTableView()
        setupDatas(coment: coment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        self.backgroundColor = .white
    }
    
    private func addViews(){
        
        self.addSubview(scoreTextView)
        self.addSubview(starView)
        self.addSubview(lineView)
        self.addSubview(tableView)
    }
    
    private func setConstrains(){
        NSLayoutConstraint.activate([
            scoreTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            scoreTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
        ])
        
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: scoreTextView.topAnchor, constant: 0),
            starView.leadingAnchor.constraint(equalTo: scoreTextView.trailingAnchor , constant: 5),
            starView.widthAnchor.constraint(equalToConstant: 150),
            starView.bottomAnchor.constraint(equalTo: scoreTextView.bottomAnchor, constant:  0)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: scoreTextView.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
       
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 15),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: VIEW_SIZE)
        ])
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ComentCell.self, forCellReuseIdentifier: Cell.ComentCellIdentifier)
    }
    
    private func setupDatas(coment: Comment){
        
        if let scorecnt = coment.scorecnt, let scoresum = coment.scoresum {
            var score = "\(String(format: "%.1f", (Float( scoresum ) / Float ( scorecnt ))))"
            let scoreText =  "\(score) 점"
            let attributedText = NSMutableAttributedString(string: scoreText)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 25, weight: .regular), range: (scoreText as NSString).range(of: "점"))
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .medium), range: (scoreText as NSString).range(of: "\(score)"))
            scoreTextView.attributedText = attributedText
            
            starView.rating = Float( scoresum ) / Float ( scorecnt )
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



extension ComentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.ComentCellIdentifier, for: indexPath) as? ComentCell else { return UITableViewCell() }
        
        cell.comment = comentList[indexPath.row]
        cell.selectionStyle = .none
        
        print("cell Height", cell.bounds.size.height)
        return cell
    }
}
