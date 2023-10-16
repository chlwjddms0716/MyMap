//
//  TargetPlaceResult.swift
//  MyMap
//
//  Created by 최정은 on 10/5/23.
//


import Foundation

// MARK: - AddressData
struct TargetPlaceResult: Codable {
    let basicInfo: BasicInfo?
    let blogReview: BlogReview?
    let comment: Comment?
    let menuInfo: MenuInfo?
    let photo: Photo?

    enum CodingKeys: String, CodingKey {
        case basicInfo
        case blogReview, comment, menuInfo, photo
    }
}

// MARK: - BasicInfo
struct BasicInfo: Codable {
    let cid: Int?
    let placenamefull: String?
    let mainphotourl: String?
    let phonenum: String?
    let address: Address?
    let homepage: String?
    let homepagenoprotocol: String?
    let feedback: Feedback?
    let openHour: OpenHour?
    let operationInfo: OperationInfo?
}

// MARK: - OperationInfo
struct OperationInfo: Codable {
    let appointment, delivery, pagekage: String?
}

// MARK: - Address
struct Address: Codable {
    let newaddr: Newaddr?
    let region: Region?
    let addrbunho: String?
    let addrdetail: String?
}

// MARK: - Newaddr
struct Newaddr: Codable {
    let newaddrfull, bsizonno: String?
}

// MARK: - Region
struct Region: Codable {
    let name3, fullname, newaddrfullname: String?
}


// MARK: - Feedback
struct Feedback: Codable {
    let allphotocnt, blogrvwcnt, comntcnt, scoresum: Int?
    let scorecnt: Int?
}

// MARK: - OpenHour
struct OpenHour: Codable {
    let periodList: [PeriodList]?
    let realtime: Realtime?
}

// MARK: - PeriodList
struct PeriodList: Codable {
    let periodName: String?
    let timeList: [TimeList]?
}

// MARK: - TimeList
struct TimeList: Codable {
    let timeName, timeSE, dayOfWeek: String?
}

// MARK: - Realtime
struct Realtime: Codable {
    let holiday, breaktime, realtimeOpen, moreOpenOffInfoExists: String?
    let datetime: String?
    let currentPeriod: PeriodList?
    let closedToday: String?

    enum CodingKeys: String, CodingKey {
        case holiday, breaktime
        case realtimeOpen = "open"
        case moreOpenOffInfoExists, datetime, currentPeriod, closedToday
    }
}


// MARK: - BlogReview
struct BlogReview: Codable {
    let placenamefull: String?
    let moreID, blogrvwcnt: Int?
    let list: [BlogReviewList]?

    enum CodingKeys: String, CodingKey {
        case placenamefull
        case moreID = "moreId"
        case blogrvwcnt, list
    }
}

// MARK: - BlogReviewList
struct BlogReviewList: Codable {
    let blogname: String?
    let blogurl: String?
    let contents: String?
    let outlink: String?
    let date, reviewid, title: String?
    let photoList: [ListPhotoList]?
    let isMy: Bool?
}

// MARK: - ListPhotoList
struct ListPhotoList: Codable {
    let orgurl: String?
}

// MARK: - Comment
struct Comment: Codable {
    let placenamefull: String?
    let kamapComntcnt, scoresum, scorecnt: Int?
    let list: [CommentList]?
    let strengthCounts: [StrengthCount]?
    let hasNext: Bool?
    let reviewWriteBlocked: String?
}

// MARK: - CommentList
struct CommentList: Codable {
    let contents: String? // 리뷰에 적은 내용
    let point: Int? // 해당 유저가 남긴 별점
    let username: String? // 리뷰 남긴 유저 이름
    let profile: String? // 리뷰 남긴 유저 프로필
    let photoCnt: Int? // 업로드 한 사진 갯수
    let thumbnail: String? // 리뷰에 올린 썸네일 이미지
    let photoList: [FluffyPhotoList]? // 업로드한 사진 리스트 (near = true) 인 경우, 가까운 위치에서 리뷰 남긴 것.
    let userCommentCount: Int?
    let userCommentAverageScore: Double? // 해당 유저가 남긴평균 별점
    let myStorePick: Bool?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case contents, point, username, profile, photoCnt, thumbnail
        case photoList, userCommentCount, userCommentAverageScore, myStorePick, date
    }
}

// MARK: - FluffyPhotoList
struct FluffyPhotoList: Codable {
    let url: String?
    let near: Bool?
}

// MARK: - StrengthCount
struct StrengthCount: Codable {
    let id: Int?
    let name: String?
    let count: Int?
}



// MARK: - MenuInfo
struct MenuInfo: Codable {
    let menucount: Int?
    let menuList: [MenuList]?
    let productyn: String?
    let menuboardphotocount: Int?
    let timeexp: String?
    let menuboardphotourlList: [String]?
}


// MARK: - MenuList
struct MenuList: Codable {
    let price: String?
    let recommend: Bool?
    let menu, desc: String?
    let img: String?
}

// MARK: - Photo
struct Photo: Codable {
    let photoList: [PhotoPhotoList]?
}

// MARK: - PhotoPhotoList
struct PhotoPhotoList: Codable {
    let photoCount: Int?
    let categoryName: String?
    let list: [PhotoListList]?
}

// MARK: - PhotoListList
struct PhotoListList: Codable {
    let photoid: String?
    let orgurl: String?
}


// MARK: - Age
struct Age: Codable {
    let labels: [String]?
    let data: [Int]?
    let max: Int?
}

// MARK: - Day
struct Day: Codable {
    let initData: [Int]?
    let labels: [String]?
    let avg, sunday, monday, tuesday: [Int]?
    let wednesday, thursday, friday, saturday: [Int]?
    let max: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
