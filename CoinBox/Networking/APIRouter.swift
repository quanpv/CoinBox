//
//  APIRouter.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/21/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation
import Alamofire
enum APIRouter: URLRequestConvertible {
    // =========== Begin define api ===========
    case coinInfo(limit: Int)
    case quickSearch
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .coinInfo:
            return .get
        case .quickSearch:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .coinInfo:
            return "v1/ticker/"
        case .quickSearch:
            return "generated/search/quick_search.json"
        }
    }
    
    private var baseURL: String {
        switch self {
        case .coinInfo:
            return Production.BASE_URL
        case .quickSearch:
            return Production.BASE_URL2
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers = ["Accept": "application/json"]
        switch self {
        case .coinInfo:
            break
        case .quickSearch:
            break
        }
        
        return headers;
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .coinInfo(let limit):
            return ["limit": limit]
        case .quickSearch:
            return nil
        }
    }
    
    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
//        let url = try Production.BASE_URL.asURL()
        let url = try baseURL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        
        return urlRequest
    }
    
    private func getAuthorizationHeader() -> String? {
        return "Authorization token"
    }
}
