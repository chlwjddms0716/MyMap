//
//  SearchResultViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import SafariServices
import UIKit

class SearchResultViewController: UIViewController {

    private let DEFAULT_SIZE = 25
    private let SELECT_SIZE = 45
    
    private let searchResultView = SearchResultView()
    private let httpManager = HttpManager.shared
    
    private var pageNum: Int = 0
    
    private var selectTag: Int = 0
    
    var keyword: String? {
        didSet{
            fetchKeywordResult()
        }
    }
    
    private var keywordResultArray: [KeywordResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddTarget()
        setupTableView()
        setupMapView()
    }

    override func loadView() {
        view = searchResultView
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupMapView(){
        searchResultView.mapView.delegate = self
    }
    
    func setupTableView(){
        searchResultView.tableView.dataSource = self
        searchResultView.tableView.delegate = self
        
        
        searchResultView.tableView.register(KeywordResultCell.self, forCellReuseIdentifier: Cell.KeywordResultCellIdentifier)
    }
   
    func setupAddTarget(){
        searchResultView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        searchResultView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        searchResultView.currentButton.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
             
        let keywordTouch = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        searchResultView.keywordLabel.addGestureRecognizer(keywordTouch)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(typeStackViewTapped))
        searchResultView.typeStackView.addGestureRecognizer(tapGesture)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
                swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        searchResultView.storeView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
                swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        searchResultView.storeView.addGestureRecognizer(swipeDown)
        
        searchResultView.storeView.topButton.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadWebView), name: NSNotification.Name.blogWebView, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTableView), name: NSNotification.Name.reviewMore, object: nil)
    }
    
    @objc func loadWebView(notification: NSNotification){
      
        if let userInfo = notification.userInfo as? [String: Any] {
            if let value = userInfo["url"] as? String {
                let blogUrl = NSURL(string: value)
                       let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
                       self.present(blogSafariView, animated: true, completion: nil)
            }
        }
    }
    
    @objc func loadTableView(notification: NSNotification){
        guard let result = searchResultView.storeView.placeResult,let blogReviewData = result.blogReview else { return }
        let vc = TableViewController()
        vc.blogReview = blogReviewData
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
   @objc func respondToSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
       if gesture.direction == UISwipeGestureRecognizer.Direction.up {
           
           if searchResultView.heightConstraint.constant != 0 {
               searchResultView.upPage()
               
               LoadingIndicator.showLoading()
               
               httpManager.getDetailDataForTargetPlace(placeCode: String(selectTag)) { result in
                   LoadingIndicator.hideLoading()
                   switch result {
                   case .success(let placeData):
                       self.searchResultView.storeView.placeResult = placeData
                       self.searchResultView.setScroll()
                   case .failure(_): break
                   }
               }
           }
       }
       else {
           searchResultView.downPage()
       }
    }
    
   @objc func topButtonTapped() {
       searchResultView.downPage()
    }
    
    func fetchKeywordResult(isDistance: Bool = true){
        pageNum = 1
        selectTag = 0
        guard let keyword = keyword else { return }
        
        LoadingIndicator.showLoading()
        
        DispatchQueue.main.async {
            self.searchResultView.mapView.removeAllPOIItems()
        }
        
        searchResultView.keywordLabel.text = keyword
        let coordinate = UserDefaultsManager.shared.currentCoordinate
        httpManager.searchKeyword(keyword: keyword, coordinate: coordinate, isDistance: isDistance) { result in
            
            LoadingIndicator.hideLoading()
            switch result {
            case .success(let resultData):
                self.keywordResultArray = resultData
                
                DispatchQueue.main.async {
                    self.addKeywordResultToMap(addArray: resultData)
                    self.searchResultView.tableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMoreKeywordResult(){
        pageNum += 1
        guard let keyword = keyword else { return }
        
        let coordinate = UserDefaultsManager.shared.currentCoordinate
        let isDistance = searchResultView.sortButton.titleLabel?.text == "거리순" ? true : false
        httpManager.searchKeyword(keyword: keyword, coordinate: coordinate, isDistance: isDistance, pageNum: String(pageNum)) { result in
            
            DispatchQueue.main.async {
                self.searchResultView.tableView.tableFooterView = nil
            }
            
            switch result {
            case .success(let resultData):
                self.keywordResultArray.append(contentsOf: resultData)
                
                DispatchQueue.main.async {
                    self.addKeywordResultToMap(addArray: resultData)
                    self.searchResultView.tableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func currentButtonTapped(){
        
        if let coordinator = UserDefaultsManager.shared.currentCoordinate {
            searchResultView.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: coordinator.latitude, longitude: coordinator.longitude)), zoomLevel: 1, animated: true)
        }
    }
    
    @objc func closeButtonTapped(){
        dismiss(animated: false) {
            
            if let vc = UIApplication.shared.keyWindow?.visibleViewController as? UIViewController, let presentVC = vc as? SearchResultViewController  {
                
                presentVC.dismiss(animated: false)
            }
        }
    }
    
    @objc func sortButtonTapped(){
        
        let vc = SortViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return 130
                }
            ]
            
            sheet.largestUndimmedDetentIdentifier  = nil
            sheet.prefersGrabberVisible = false
        }
        
        vc.isDistanceSelect = self.searchResultView.sortButton.titleLabel?.text == "거리순" ? true : false
        vc.buttonPressed = { (isClose, isDistanceSelect) in
            if isClose {
                vc.dismiss(animated: true)
            }
            else {
                let isChange = self.searchResultView.sortButton.titleLabel?.text == "거리순" && isDistanceSelect ? false : true
                
                if isChange {
                    self.searchResultView.sortButton.setTitle(isDistanceSelect ? "거리순" : "정확도순", for: .normal)
                    self.fetchKeywordResult(isDistance: isDistanceSelect)
                }
                
                vc.dismiss(animated: true)
            }
        }
       
        present(vc, animated: true)
    }

   
    @objc func typeStackViewTapped(){
        print(#function)
        DispatchQueue.main.async {
            self.setupResultType()
        }
    }
    
    func setupResultType(isSelectPlace: Bool = false, tag: Int = 0){
        
        if keywordResultArray.count <= 0 {
            return
        }
        
        if searchResultView.typeLabel.text == "지도"  {
            searchResultView.typeLabel.text = "목록"
            searchResultView.typeChangeButton.setImage(UIImage(systemName: "list.bullet")?.withTintColor( UIColor(hexCode: Color.pointColor), renderingMode: .alwaysOriginal), for: .normal)
            
            searchResultView.tableView.isHidden = true
            
            changeMarker(tag: isSelectPlace ? tag : 0)
        }
        else {
            searchResultView.typeLabel.text = "지도"
            searchResultView.typeChangeButton.setImage(UIImage(systemName: "map.fill")?.withTintColor( UIColor(hexCode: Color.pointColor), renderingMode: .alwaysOriginal), for: .normal)
            
            searchResultView.tableView.isHidden = false
        }
    }
    
    func changeMarker(tag: Int = 0){
        
        var changeTag = tag
        if tag == 0, let tag = Int( keywordResultArray[0].id ) {
            changeTag = tag
        }
        selectTag = changeTag
        
        if let markerArray = self.searchResultView.mapView.poiItems as? [MTMapPOIItem] {
            markerArray.forEach { item in
               
                if item.tag == changeTag {
                    item.customImage = self.setImageSize(imageName: "selectMarker", width: SELECT_SIZE, height: SELECT_SIZE)
                }
                else{
                    item.customImage = self.setImageSize(imageName: "defaultMarker", width: DEFAULT_SIZE, height: DEFAULT_SIZE)
                  
                }
            }
            
            DispatchQueue.main.async {
                self.searchResultView.mapView.removeAllPOIItems()
                self.searchResultView.mapView.addPOIItems(markerArray)
            }
        }
        
        guard  let selectItem = keywordResultArray.first(where: { $0.id == String(selectTag)}), let latitude = Double( selectItem.y), let longitude = Double(selectItem.x) else { return }
        searchResultView.storeView.keywordResult = selectItem
        
        searchResultView.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude)), zoomLevel: 1, animated: true)
    }
    
    func addKeywordResultToMap(addArray: [KeywordResult]){
        
        for place in addArray {
            if let latitude = Double(place.y), let longitude = Double(place.x)  {
                let marker = MTMapPOIItem()
                marker.tag = Int(place.id)!
                
                marker.markerType = .customImage // 사용자 정의 이미지 사용
                
                if place.id == keywordResultArray.first?.id {
                    marker.customImage = self.setImageSize(imageName: "selectMarker", width: SELECT_SIZE, height: SELECT_SIZE)
                }else{
                    marker.customImage = self.setImageSize(imageName: "defaultMarker", width: DEFAULT_SIZE, height: DEFAULT_SIZE)
                }
                
                marker.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
                
                searchResultView.mapView.add(marker)
            }
        }
        
        guard let selectItem = keywordResultArray.first, let latitude = Double( selectItem.y), let longitude = Double(selectItem.x) else { return }
        searchResultView.storeView.keywordResult = selectItem
        
        searchResultView.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude)), zoomLevel: 1, animated: true)
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultView.tableView.dequeueReusableCell(withIdentifier: Cell.KeywordResultCellIdentifier, for: indexPath) as? KeywordResultCell else { return UITableViewCell()}
        
        cell.keywordResult = keywordResultArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let phone = keywordResultArray[indexPath.row].phone, phone.count > 0 {
            return 95
        }
        else {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setupResultType(isSelectPlace: true, tag: Int(keywordResultArray[indexPath.row].id)!)
    }
    
    private func createSpinnerFooter() -> UIView {
           let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
           
           let spinner = UIActivityIndicatorView()
           spinner.center = footerView.center
           footerView.addSubview(spinner)
           spinner.startAnimating()
           
           return footerView
       }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (searchResultView.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            searchResultView.tableView.tableFooterView = createSpinnerFooter()
            
            fetchMoreKeywordResult()
        }
    }
}

extension SearchResultViewController: MTMapViewDelegate {
    
    func setImageSize(imageName: String, width: Int, height: Int) -> UIImage {
        let customImage = UIImage(named: imageName)

        // 이미지 크기 조절
        let newSize = CGSize(width: width , height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        customImage?.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage ?? UIImage()
    }
    
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        
        changeMarker(tag: poiItem.tag)
        
        return true
    }
}
