//
//  SearchResult.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation
import ObjectMapper

/// iTunes main search array model
class ResultArray: Mappable {
    var resultCount: Int?
    var results: [SearchResult]?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        resultCount <- map["resultCount"]
        results <- map["results"]
    }
}

/// iTunes search item model
class SearchResult : Mappable {
    var artworkUrl100: String?
    var collectionName: String?
    var collectionViewUrl: String?
    var collectionPrice: Double?
    var currency: String = ""
    var itemPrice: Double?
    var itemGenre: String?
    var kind: String?
    var releaseDate: String?
    var trackViewUrl: String?
    var trackName: String?
    var trackPrice: Double?

    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        artworkUrl100 <- map["artworkUrl100"]
        collectionName <- map["collectionName"]
        collectionViewUrl <- map["collectionViewUrl"]
        collectionPrice <- map["collectionPrice"]
        currency <- map["currency"]
        itemPrice <- map["itemPrice"]
        itemGenre <- map["itemGenre"]
        kind <- map["kind"]
        releaseDate <- map["releaseDate"]
        trackViewUrl <- map["trackViewUrl"]
        trackName <- map["trackName"]
        trackPrice <- map["trackPrice"]
    }
    
    var name: String {
        return collectionName ?? trackName ?? ""
    }
    
    var storeUrl: String {
        return collectionViewUrl ?? trackViewUrl ?? ""
    }
    
    var storePrice: Double {
        return collectionPrice ?? trackPrice ?? itemPrice ?? 0.0
    }
}
