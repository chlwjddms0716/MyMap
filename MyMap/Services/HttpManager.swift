//
//  HttpManager.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import Foundation
import Alamofire

final class HttpManager {
    
    static let shared = HttpManager()
    private init() {}
    
    typealias ConvertCompletion = (Result<AddressResultData, AFError>) -> (Void)
    typealias SearchKeywordCompletion = (Result<[KeywordResult], AFError>) -> (Void)
    typealias TargetPlaceCompletion = (Result<TargetPlaceResult, AFError>) -> (Void)
   
    private let headers : HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept":"application/json",
        "Authorization": "KakaoAK \(KakaoApi.ApiKey)"
    ]
    
    // MARK: - 좌표로 주소 찾기
    func convertCoordToAddress(longitude: String, latitude: String, completion: @escaping  ConvertCompletion) {
        
        let url = "\(KakaoApi.CoordToAddressURL)x=\(longitude)&y=\(latitude)"
        print(url)

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: AddressResultData.self) { response in
            
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 좌표, 키워드로 검색하기
    func searchKeyword(keyword: String, coordinate: Coordinate?, isDistance: Bool = true, pageNum: String = "",  completion: @escaping SearchKeywordCompletion){
        
        var url = "\(KakaoApi.SearchKeywordURL)query=\(keyword)"
        
        if pageNum.count > 0 {
            url += "&page=\(pageNum)"
        }
        
        url += isDistance ? "&sort=distance" : ""
        
        if let coordinate = coordinate {
            url += "&x=\(coordinate.longitude)&y=\(coordinate.latitude)"
        }
        
        print(url)

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: KeywordResultData.self) { response in
            
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData.documents))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 지정된 위치에 해당하는 카카오맵 데이터 크롤링하기
    func getDetailDataForTargetPlace(placeCode: String, completion: @escaping TargetPlaceCompletion) {
        
        let url = KakaoApi.TargetPlaceURL + placeCode
        print(url)
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: TargetPlaceResult.self) { response in
            let result = response.result
            switch result {
            case .success(let results):
                print("정보 가져오기 성공")
                completion(.success(results))
                return
            case .failure(let error):
                print("정보 가져오기 실패 : \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
