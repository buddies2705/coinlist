//
//  ServiceManager.swift
//
//
//  Created by Amit Kumar on 4/13/17.
//  Copyright © 2017 Amit Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//MARK: - Failure Message
let failureMessage : JSON = ["message": "Something went wrong with request.Please check your internet connection and try again"]


//MARK: - Encodeing Array to Send as Paramter

struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]
    
    init(array: [Parameters]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = data
        return urlRequest
    }
}



class ServiceManager: NSObject {
    
    class func getRequestWithFullUrl(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (JSON) -> Void) {
        
        var urlRequest : URLRequest?
        if let finalRequestUrl = URL(string : strURL){
            
            var request = URLRequest(
                url: finalRequestUrl,
                cachePolicy: .returnCacheDataElseLoad,
                timeoutInterval: 604800)
            request.httpMethod = "GET"
            urlRequest = request
        }
        
        if(urlRequest == nil){return}
        
        // Changing Cache policy if cache already exist.
        if (self.isConnectedToInternet() && URLCache.shared.cachedResponse(for: urlRequest!) != nil){
            URLCache.shared.removeCachedResponse(for: urlRequest!)
            
            urlRequest!.cachePolicy = .reloadIgnoringLocalCacheData
            
        }
        
        Alamofire.request(urlRequest! as URLRequestConvertible).validate().responseJSON {(responseObject) -> Void in
            
            
            
            if responseObject.result.isSuccess {
                if let requestResponse = responseObject.result.value {
                    let resJson = JSON(requestResponse)
                    print("Get Request Response :",resJson)
                    success(resJson)
                }
            }
            
            
            if responseObject.result.isFailure {
                
                if let data = responseObject.data {
                    do {
                        let responseJSON = try JSON(data: data)
                        print("Get Request Error :",responseJSON)
                        if(responseJSON.isEmpty){
                            failure(failureMessage)
                        }else {
                            failure(responseJSON)
                        }
                    }catch {
                        failure(failureMessage)
                        
                        print("Get Request Error Exception")
                    }
                }else {
                    failure(failureMessage)
                    
                }
            }
        }
    }
    
 
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
}
