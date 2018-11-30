//
//  CoinResponse.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/22/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation
import ObjectMapper
class CoinResponse: Mappable {
    var id : String?
    var name : String?
    var symbol: String?
   var rank: String?
    var price_usd: String?
    var price_btc: String?
     var volume_usd_24h: String?
    var market_cap_usd: String?
    var available_supply: String?
    var total_supply: String?
    var max_supply: String?
    var percent_change_1h: String?
    var percent_change_24h: String?
    var percent_change_7d: String?
    var last_updated: String?
    
    var idThumb: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {   
        id <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
         symbol <- map["symbol"]
         rank <- map["rank"]
         price_usd <- map["price_usd"]
         price_btc <- map["price_btc"]
         volume_usd_24h <- map["24h_volume_usd"]
         market_cap_usd <- map["market_cap_usd"]
         available_supply <- map["available_supply"]
           total_supply <- map["total_supply"]
           max_supply <- map["max_supply"]
           percent_change_1h <- map["percent_change_1h"]
           percent_change_24h <- map["percent_change_24h"]
           percent_change_7d <- map["percent_change_7d"]
         last_updated <- map["last_updated"]
    }
    
}
