//
//  MainViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    private let authManager = AuthManager.shared
    
    private let mainView = MainView()
    
    var marker: MTMapPOIItem = {
        let marker = MTMapPOIItem()
        marker.itemName = "currentMark"
        marker.markerType = .customImage // 커스텀 이미지를 사용하는 마커
        marker.customImageName = "currentIcon"
        return marker
    }()

    let httpManager = HttpManager.shared
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
        setupCollectionView()
        setupMapView()
        setupAddTarget()
    }
    
    override func loadView() {
        
        view = mainView
    }
    
    func setupCollectionView(){
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(KeywordCell.self
                                , forCellWithReuseIdentifier: Cell.MainKeywordCellIdentifier)
    }
    
    func setupAddTarget(){
        mainView.homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        mainView.currentButton.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        mainView.myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        mainView.mapSettingButton.addTarget(self, action: #selector(mapSettingTapped), for: .touchUpInside)
        mainView.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchBarViewTapped(_:)))
        mainView.searchBarView.addGestureRecognizer(tapGesture)
    }
    
    func setupMapView(){
        if let mapType = UserDefaultsManager.shared.currentMapType {
            mainView.mapView.baseMapType = mapType
        }
        mainView.mapView.delegate = self
    }
  
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func currentButtonTapped(){
        
        if let coordinator = UserDefaultsManager.shared.currentCoordinate {
            mainView.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: coordinator.latitude, longitude: coordinator.longitude)), zoomLevel: 1, animated: true)
        }
    }
    
    @objc func myButtonTapped(){
        let vc = MyViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return self.view.bounds.height * 0.4
                },
                .custom { _ in
                    return self.view.bounds.height * 0.8
                }
            ]
            sheet.prefersGrabberVisible = true
        }
       
        present(vc, animated: true)

    }
    
    @objc func homeButtonTapped(){
        
    }
    
    @objc func bookmarkButtonTapped(){
        
    }
    
    @objc func searchBarViewTapped(_ gesture: UITapGestureRecognizer) {
        
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @objc func mapSettingTapped(){
        
        let vc = MapSettingViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return 220
                }
            ]
            
            sheet.largestUndimmedDetentIdentifier  = nil
            sheet.prefersGrabberVisible = false
        }
        
        vc.mapTypeTapped = { mapType in
            self.mainView.mapView.baseMapType = mapType
            UserDefaultsManager.shared.setCurrentMapType(mapType: mapType)
        }
       
        present(vc, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // 권한 변경
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1]
        let longitude: CLLocationDegrees = location.coordinate.longitude
        let latitude: CLLocationDegrees = location.coordinate.latitude
        
        UserDefaultsManager.shared.setCurrentCoordinate(coordinate: Coordinate(longitude: longitude, latitude: latitude))
        
        marker.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
        
        if self.mainView.mapView.findPOIItem(byName: marker.itemName) == nil {
            mainView.mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude)), zoomLevel: 1, animated: true)
            
            httpManager.convertCoordToAddress(longitude: String(longitude), latitude: String(latitude)) { result in
                switch result {
                case .success(let data):
                    
                    if let roadAddressData = data.documents, let AddressData = roadAddressData.first {
                        DispatchQueue.main.async {
                            self.mainView.searchLabel.text = "\(AddressData.address.region2DepthName) \(AddressData.address.region3DepthName)"
                        }
                    }
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
        else {
            mainView.mapView.remove(marker)
        }
     
        mainView.mapView.addPOIItems([marker])
    }
}

extension MainViewController: MTMapViewDelegate {
    
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        if poiItem.itemName == marker.itemName {
            return false
        }
       
        return true
    }
 
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
           let currentLocation = location?.mapPointGeo()
           if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
               print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
           }
       }
       
       func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
           print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
       }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KeywordManager.MainKeywordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.MainKeywordCellIdentifier, for: indexPath) as? KeywordCell else { return  UICollectionViewCell() }
        
        cell.keyword = KeywordManager.MainKeywordArray[indexPath.row]
        cell.isBorderUse = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SearchViewController()
        vc.keyword = KeywordManager.MainKeywordArray[indexPath.row].keyword
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
