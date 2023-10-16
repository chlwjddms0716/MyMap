//
//  AuthManager.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

public struct AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
   typealias UserCompletion = (User?) -> (Void)
    
    // MARK: - 카카오톡으로 로그인
    func kakaoLoginWithKakaoTalk(completion: @escaping UserCompletion){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                }
                else {
                    self.kakaoGetUserInfo { user in
                        completion(user)
                    }
                }
            }
        }
    }
    
    // MARK: - 카카오톡 계정으로 로그인
    func kakaoLogin(completion: @escaping UserCompletion){
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                }
                else {
                    self.kakaoGetUserInfo { user in
                        completion(user)
                    }
                }
            }
    }
    
    // MARK: - 로그인된 이용자 가져오기
   private func kakaoGetUserInfo(completion: @escaping UserCompletion) {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
                completion(nil)
            }
            
            if let user = user, let kakaoAcount = user.kakaoAccount, let uid = user.id, let profile = kakaoAcount.profile {
            
                if let imageURL = profile.profileImageUrl {
                    
                }
                let user = User(uid: String(uid), name: profile.nickname, email: kakaoAcount.email, gender: kakaoAcount.gender?.rawValue, imageURL: "\(String(describing: profile.profileImageUrl))", birthDay: kakaoAcount.birthday)
                
                completion(user)
                return
            }
            completion(nil)
        }
    }

    
     func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("Logout Success")
            }
        }
    }
}
