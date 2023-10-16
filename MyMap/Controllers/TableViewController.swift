//
//  TableViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/12/23.
//

import UIKit
import SafariServices

class TableViewController: UIViewController {

    private let tableView = TableView()
    
    var blogReview: BlogReview? {
        didSet {
            guard let blogReview = blogReview, let blogReviewList = blogReview.list else { return }
            tableView.setupBlogReviewView(placeName: blogReview.placenamefull, blogReview: blogReviewList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
    }
    
    override func loadView() {
        view = tableView
    }
    
    private func addTargets(){
        tableView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBlogWebView(notification:)), name: Notification.Name.blogWebView, object: nil)
    }
    
    @objc func showBlogWebView(notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            if let value = data["url"] as? String {
                let blogUrl = NSURL(string: value)
                let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
                self.present(blogSafariView, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func closeButtonTapped(){
      
        dismiss(animated: false)
    }
}
