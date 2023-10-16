//
//  Keyword.swift
//  MyMap
//
//  Created by 최정은 on 10/3/23.
//

import Foundation

struct Keyword {
    
    let keyword: String
    let image: UIImage
}

struct KeywordManager{
    
    private init() {}
    
    static let MainKeywordArray: [Keyword] = [
        Keyword(keyword: "맛집", image: UIImage(named: "restaurant")!.withTintColor(.orange, renderingMode: .alwaysOriginal)),
        Keyword(keyword: "카페", image: UIImage(named: "cafe")!.withTintColor(.orange, renderingMode: .alwaysOriginal)),
        Keyword(keyword: "편의점", image: UIImage(named: "store")!.withTintColor(.yellow, renderingMode: .alwaysOriginal)),
        Keyword(keyword: "숙소", image: UIImage(named: "bed")!.withTintColor(.purple, renderingMode: .alwaysOriginal)),
        Keyword(keyword: "주차장", image: UIImage(named: "park")!.withTintColor(.black, renderingMode: .alwaysOriginal)),
        Keyword(keyword: "주유소", image: UIImage(named: "gasPump")!.withTintColor(.black, renderingMode: .alwaysOriginal)),
    ]
    
    static let SearchKeywordArray: [Keyword] = [
        Keyword(keyword: "맛집", image: UIImage(named: "restaurant")!),
        Keyword(keyword: "카페", image: UIImage(named: "cafe")!),
        Keyword(keyword: "편의점", image: UIImage(named: "store")!),
        Keyword(keyword: "마트", image: UIImage(named: "cart")!),
        Keyword(keyword: "약국", image: UIImage(named: "pill")!),
        Keyword(keyword: "주유소", image: UIImage(named: "gasPump")!),
        Keyword(keyword: "지하철역", image: UIImage(named: "subway")!),
        Keyword(keyword: "주차장", image: UIImage(named: "park")!),
        Keyword(keyword: "우체국", image: UIImage(named: "post")!),
        Keyword(keyword: "은행", image: UIImage(named: "bank")!),
    ]
}
