//
//  MapSettingViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class MapSettingViewController: UIViewController {

    private let mapSettingView = MapSettingView()
    
    var mapTypeTapped: (MTMapType) -> (Void) = {(sender) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func loadView() {
        view = mapSettingView
    }

    func configureUI(){
        let standartGesture = UITapGestureRecognizer(target: self, action: #selector(standardStackViewTapped))
        mapSettingView.standardStackView.addGestureRecognizer(standartGesture)
        
        let hybridGesture = UITapGestureRecognizer(target: self, action: #selector(hybridStackViewTapped))
        mapSettingView.hybridStackView.addGestureRecognizer(hybridGesture)
        
        if let mapType = UserDefaultsManager.shared.currentMapType {
            selectMapType(isStandardSelect: mapType == .standard)
        }
    }
    
    @objc func standardStackViewTapped(){
       
        selectMapType(isStandardSelect: true)
        mapTypeTapped(.standard)
    }
    
    @objc func hybridStackViewTapped(){
        
        selectMapType(isStandardSelect: false)
        mapTypeTapped(.hybrid)
    }
    
    func selectMapType(isStandardSelect: Bool){
        DispatchQueue.main.async {
            if isStandardSelect {
                self.mapSettingView.hybridLabel.textColor = .gray
                self.mapSettingView.hybridImageView.image = UIImage(named: "hybridMap")
                
                self.mapSettingView.standardLabel.textColor = UIColor(hexCode: Color.pointColor)
                self.mapSettingView.standardImageView.image = UIImage(named: "standardMapSelect")
            }
            else{
                self.mapSettingView.standardLabel.textColor = .gray
                self.mapSettingView.standardImageView.image = UIImage(named: "standardMap")
                
                self.mapSettingView.hybridLabel.textColor = UIColor(hexCode: Color.pointColor)
                self.mapSettingView.hybridImageView.image = UIImage(named: "hybridMapSelect")
            }
        }
    }
}
