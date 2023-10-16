//
//  AddressResult.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import Foundation

// MARK: - AddressData
struct AddressResultData: Codable {
    let documents: [AddressResultDocument]?
}

// MARK: - Document
struct AddressResultDocument: Codable {
    let roadAddress: RoadAddress
    let address: AddressResult

    enum CodingKeys: String, CodingKey {
        case roadAddress = "road_address"
        case address
    }
}

// MARK: - Address
struct AddressResult: Codable {
    let addressName, region1DepthName, region2DepthName, region3DepthName: String
    let mountainYn, mainAddressNo, subAddressNo, zipCode: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case region1DepthName = "region_1depth_name"
        case region2DepthName = "region_2depth_name"
        case region3DepthName = "region_3depth_name"
        case mountainYn = "mountain_yn"
        case mainAddressNo = "main_address_no"
        case subAddressNo = "sub_address_no"
        case zipCode = "zip_code"
    }
}

// MARK: - RoadAddress
struct RoadAddress: Codable {
    let addressName, region1DepthName, region2DepthName, region3DepthName: String
    let roadName, undergroundYn, mainBuildingNo, subBuildingNo: String
    let buildingName, zoneNo: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case region1DepthName = "region_1depth_name"
        case region2DepthName = "region_2depth_name"
        case region3DepthName = "region_3depth_name"
        case roadName = "road_name"
        case undergroundYn = "underground_yn"
        case mainBuildingNo = "main_building_no"
        case subBuildingNo = "sub_building_no"
        case buildingName = "building_name"
        case zoneNo = "zone_no"
    }
}

