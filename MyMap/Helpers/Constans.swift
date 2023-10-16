//
//  Constans.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import Foundation

public struct KakaoApi {
    
    private init(){}
    
    static let ApiKey = "40adf8a12098b651ee53e7894ffc6ff8"
    static let CoordToAddressURL = "https://dapi.kakao.com/v2/local/geo/coord2address.json?"
    static let SearchKeywordURL = "https://dapi.kakao.com/v2/local/search/keyword.json?"
    static let TargetPlaceURL = "https://place.map.kakao.com/main/v/"
}

public struct Cell {
    
    private init(){}
    
    static let MainKeywordCellIdentifier = "KeywordCell"
    static let HistoryCellIdentifier = "HistoryCell"
    static let KeywordResultCellIdentifier = "KeywordResultCell"
    static let ComentCellIdentifier = "ComentCell"
    static let PhotoCellIdentifier = "PhotoCell"
    static let BlogReviewCellIdentifier = "BlogReviewCell"
}

public struct Color {
    
    private init(){}
    
    static let pointColor = "F7786B"
    static let blueColor = "4695E8"
    static let grayColor = "F0F0F0"
    static let lightGrayColor = "FAFAFA"
    static let yelloColor = "F6E24B"
    static let redColor = "EC645F"
    static let greenColor = "61A27F"
}
