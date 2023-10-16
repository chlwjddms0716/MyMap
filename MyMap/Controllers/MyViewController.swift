//
//  MyViewController.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import UIKit

class MyViewController: UIViewController {

    private let myView = MyView()
    
    private let authManager = AuthManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginStatus()
        setupAddTarget()
    }
    
    override func loadView() {
        view = myView
    }
    
    func setupAddTarget(){
        myView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped(){
        authManager.kakaoLogout()
        
        userDefaultsManager.removeUserInfo()
        setLogoutUI()
    }
    
    @objc func loginButtonTapped(){
        print(#function)
        let vc = LoginPopupViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.buttonPressed = { (isLogin, isWithKaKaoLogin) in
            
            vc.dismiss(animated: false)
            
            if isLogin {
                if isWithKaKaoLogin {
                    self.authManager.kakaoLoginWithKakaoTalk { user in
                        guard let user = user else { return }
                        self.userDefaultsManager.setUserInfo(user: user)
                        self.setLoginUI(user: user)
                    }
                }
                else {
                    self.authManager.kakaoLogin { user in
                        guard let user = user else { return }
                        self.userDefaultsManager.setUserInfo(user: user)
                        self.setLoginUI(user: user)
                    }
                }
            }
            
            return
        }
        present(vc, animated: false)
    }
    
    func setLoginUI(user: User){
        DispatchQueue.main.async {
            self.myView.userNameLabel.text = user.name
            self.myView.logoutButton.isHidden = false
        }
        
        UIImage().loadImage(imageUrl: user.imageURL) { imageData in
            DispatchQueue.main.async {
                self.myView.userImageView.image = imageData
            }
        }
        
        self.myView.userNameLabel.gestureRecognizers = nil
    }
    
    func setLogoutUI(){
        DispatchQueue.main.async {
            self.myView.logoutButton.isHidden = true
            self.myView.userNameLabel.text = "로그인하세요"
            self.myView.userImageView.image = UIImage(named: "defaultProfile")

            if self.myView.userNameLabel.gestureRecognizers == nil {
                let loginGes = UITapGestureRecognizer(target: self
                                                      , action: #selector(self.loginButtonTapped))
                self.myView.userNameLabel.addGestureRecognizer(loginGes)
                self.myView.userNameLabel.isUserInteractionEnabled = true
            }
        }
    }
   
    func setLoginStatus(){
        
        guard let user = userDefaultsManager.getUserInfo() else {
            setLogoutUI()
            return
        }
        
        setLoginUI(user: user)
    }
}
