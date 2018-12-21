//
//  Configs.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/21/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation

struct Production {
    static let BASE_URL: String = "https://api.coinmarketcap.com/" // Thay thế bằng Base url mà bạn sử dụng ở đây
    static let BASE_URL2: String = "https://s2.coinmarketcap.com/"
    static let BASE_URL3: String = "https://min-api.cryptocompare.com/"
    static let IMAGE_URL_FORMAT = "https://s2.coinmarketcap.com/static/img/coins/32x32/%d.png"
    static let COIN_MARKETCAP_QUICK_SEARCH_URL = "https://s2.coinmarketcap.com/generated/search/quick_search.json"
}

enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}
