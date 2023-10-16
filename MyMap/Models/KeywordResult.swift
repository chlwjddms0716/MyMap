//
//  KeywordResult.swift
//  MyMap
//
//  Created by 최정은 on 10/4/23.
//

import Foundation


struct KeywordResultData: Codable {
    let documents: [KeywordResult]
    let meta: Meta
}

struct KeywordResult: Codable {
    let addressName: String
    let distance, id, placeName: String
    let placeURL: String
    let roadAddressName, x, y: String
    let categoryGroupName: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
        case categoryGroupName = "category_group_name"
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
