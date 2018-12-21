//
//  NewsResponse.swift
//  CoinBox
//
//  Created by Pham Van Quan on 12/19/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsResponse : Mappable {
    var id: String?
    var guid: String?
    var publishedOn: Int?
    var imageurl: String?
    var title: String?
    var url: String?
    var source, body, tags, categories: String?
    var upvotes, downvotes, lang: String?
    var sourceInfo: SourceInfo?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        guid <- map["guid"]
        publishedOn <- map["published_on"]
        imageurl <- map["imageurl"]
        title <- map["title"]
        url <- map["url"]
        source <- map["source"]
        body <- map["body"]
        tags <- map["tags"]
        upvotes <- map["upvotes"]
        downvotes <- map["downvotes"]
        lang <- map["lang"]
        sourceInfo <- map["source_info"]
    }
    
    // https://min-api.cryptocompare.com/data/news/
 
}

class SourceInfo: Mappable {
    var name, lang: String?
    var img: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        lang <- map["lang"]
        img <- map["img"]
    }
    
}
