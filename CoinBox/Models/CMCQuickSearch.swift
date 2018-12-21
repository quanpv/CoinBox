//
//  CMCQuickSearch.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/26/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation
import ObjectMapper

class CMCQuickSearch: Mappable {
    var slug:String?
    var id:Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        slug <- map["slug"]
        id <- map["id"]
    }
    
}
