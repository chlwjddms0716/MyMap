//
//  UserDefaultManager.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//

import Foundation

struct UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    var userEmail: String {
        return UserDefaults.standard.object(forKey: "email") as! String
    }
    /// 현재 로그인 된 유저 정보를 UserDefaults에 저장한다.
    func setUserInfo(user: User) {
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.uid, forKey: "uid")
        UserDefaults.standard.set(user.gender, forKey: "gender")
        UserDefaults.standard.set(user.imageURL, forKey: "imageURL")
        UserDefaults.standard.set(user.birthDay, forKey: "birthDay")
    }

    func removeUserInfo() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "birthDay")
        UserDefaults.standard.removeObject(forKey: "imageURL")
        UserDefaults.standard.removeObject(forKey: "gender")
    }
    
    func getUserInfo() -> User? {
        guard let uid = UserDefaults.standard.object(forKey: "uid") as? String else { return nil}
        
        let name = UserDefaults.standard.object(forKey: "name") as? String
        let email = UserDefaults.standard.object(forKey: "email") as? String
        let birthDay = UserDefaults.standard.object(forKey: "birthDay") as? String
        let imageURL = UserDefaults.standard.object(forKey: "imageURL") as? String
        let gender = UserDefaults.standard.object(forKey: "gender") as? String
        
        return User(uid: uid, name: name, email: email, gender: gender, imageURL: imageURL, birthDay: birthDay)
    }
    
    // MARK: - Coordinate
    
    var currentCoordinate: Coordinate? {
        
        guard let longitude = UserDefaults.standard.value(forKey: "currentLongtitude") as? Double else { return nil}
        let latitude = UserDefaults.standard.value(forKey: "currentLatitude") as! Double
        
        return Coordinate(longitude: longitude, latitude: latitude)
    }
    
    func setCurrentCoordinate(coordinate: Coordinate) {
        let longtitude = coordinate.longitude
        let latitude = coordinate.latitude
        
        UserDefaults.standard.set(longtitude, forKey: "currentLongtitude")
        UserDefaults.standard.set(latitude, forKey: "currentLatitude")
    }
    
    var currentMapType: MTMapType? {
        var mapType = MTMapType.standard
        if let currentMapType = UserDefaults.standard.value(forKey: "mapType") as? Int {
            mapType = MTMapType(rawValue: currentMapType) ?? .standard
        }
        
        return mapType
    }
    
    func setCurrentMapType(mapType: MTMapType) {
        UserDefaults.standard.set(mapType.rawValue, forKey: "mapType")
    }
}
