//
//  LoginPopupViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import UIKit

class LoginPopupViewController: UIViewController {

    private let loginPopupView = LoginPopupView()
    
    var buttonPressed: (Bool, Bool) -> (Void) = {(isLogin, isWithKaKaoLogin) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTarget()
    }
    
    override func loadView() {
        view = loginPopupView
    }

    private func setupTarget(){
        loginPopupView.closeButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        loginPopupView.loginWithKaKaoButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        loginPopupView.loginButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ button: UIButton){
        
        switch button {
        case loginPopupView.closeButton :
            buttonPressed(false, false)
        case loginPopupView.loginWithKaKaoButton :
            buttonPressed(true, true)
            break
        case loginPopupView.loginButton:
            buttonPressed(true, false)
            break
        default:
            buttonPressed(false, false)
            break
        }
    }
}
