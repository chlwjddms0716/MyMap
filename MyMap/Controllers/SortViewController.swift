//
//  SortViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/10/23.
//

import UIKit

class SortViewController: UIViewController {

    var buttonPressed: (Bool, Bool) -> (Void) = {(isClose, isDistanceSelect) in }
    
    var isDistanceSelect: Bool = true
    
    private let sortView = SortView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
    }
    
    override func loadView() {
        view = sortView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setButtonSelect()
    }
    
    private func addTargets(){
        sortView.closeButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        sortView.accuracyButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        sortView.distanceButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ button: UIButton){
        switch button {
        case sortView.closeButton:
            buttonPressed(true, false)
        case sortView.accuracyButton:
            buttonPressed(false, false)
        case sortView.distanceButton:
            buttonPressed(false, true)
        default:
            buttonPressed(true, false)
        }
    }
    
    private func setButtonSelect(){
        
        sortView.distanceButton.setTitleColor(.lightGray, for: .normal)
        sortView.distanceButton.layer.borderWidth = 1
        sortView.distanceButton.layer.borderColor = UIColor.lightGray.cgColor
        
        sortView.accuracyButton.setTitleColor(.lightGray, for: .normal)
        sortView.accuracyButton.layer.borderWidth = 1
        sortView.accuracyButton.layer.borderColor = UIColor.lightGray.cgColor
    
        if isDistanceSelect {
            sortView.distanceButton.layer.borderColor = UIColor(hexCode: Color.pointColor).cgColor
            sortView.distanceButton.setTitleColor(UIColor(hexCode: Color.pointColor), for: .normal)
            sortView.distanceButton.layer.borderWidth = 2
        }
        else {
            sortView.accuracyButton.layer.borderColor = UIColor(hexCode: Color.pointColor).cgColor
            sortView.accuracyButton.setTitleColor(UIColor(hexCode: Color.pointColor), for: .normal)
            sortView.accuracyButton.layer.borderWidth = 2
        }
    }
}
