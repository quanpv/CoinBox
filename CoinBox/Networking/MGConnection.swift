//
//  MGConnection.swift
//  CoinBox
//
//  Created by Pham Van Quan on 11/22/18.
//  Copyright © 2018 Pham Van Quan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class MGConnection {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            // Xử lý khi lỗi kết nối internet
            return
        }

        Alamofire.request(apiRouter).responseObject {(response: DataResponse<BaseResponse<T>>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.isSuccessCode())! {
                        completion((response.result.value?.data)!, nil)
                    } else {
                        let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.API_ERROR, (response.result.value?.code)!, (response.result.value?.message)!)
                        completion(nil, err)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
    
    static func requestArray<T: Mappable>(_ apiRouter: APIRouter, _ returnType: T.Type, completion: @escaping (_ result: [T]?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            // Xử lý khi lỗi kết nối internet
            return
        }
        
        Alamofire.request(apiRouter).responseArray {(response: DataResponse<[T]>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                     completion(response.result.value, nil)
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                break
            }
        }
    }
    
    static func testAlamofire() {
        let URL = "https://api.coinmarketcap.com/v1/ticker/?limit=10"
        Alamofire.request(URL).responseArray { (response: DataResponse<[CoinResponse]>) in
            
            let forecastArray = response.result.value
            
            if let forecastArray = forecastArray {
                for forecast in forecastArray {
                    print(forecast.name ?? "-")
                    print(forecast.price_usd ?? "-")
                }
            }
        }
    }
    
    static func getCMCQuickSearch(completion: (_ result: [CMCQuickSearch]?, _ error: BaseResponseError?)->Void) {
        Alamofire.request(Production.COIN_MARKETCAP_QUICK_SEARCH_URL).responseArray { (response: DataResponse<[CMCQuickSearch]>) in
            
            let dataResponse = response.result.value
            
            if let dataResponse = dataResponse {
                for forecast in dataResponse {
                    print(forecast.slug ?? "-")
                    print(forecast.id ?? "-")
                }
            }
        }
    }
}
