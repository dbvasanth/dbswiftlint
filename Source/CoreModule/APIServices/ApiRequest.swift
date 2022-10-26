//
//  ApiRequest.swift
//  MyPlans
//
//  Created by macbook  on 11/06/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation
import UIKit


let APIREQUEST = ApiRequest.sharedInstance

class ApiRequest{
    static let sharedInstance:ApiRequest = {
        let instance = ApiRequest()
        return instance
    }()
    
    
    //----------------------------------------------------------------------------
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@ MARK:- ApiRequest @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func apiRequest<T:Decodable>(url:String,parameter: DictionaryType,method:HTTPMethod,completion: @escaping (Result<T>) -> ())
    {
         Internet.isAvailable(completion: { (status, message) in
            if status{
                debugPrint("Passed Parameter : \(parameter)")
                debugPrint("url",url)
                self.configRequest(url: url, method: method,parameter:parameter, completion: { (response) in
                DispatchQueue.main.async {
                    completion(response)
                }
            })
            }
            else{
                DispatchQueue.main.async {
                    completion(Result<T>.failure(message: message))
                }
            }
        })
    }
    
    
    //----------------------------------------------------------------------------
    // @@@@@@@@@@@@@@@@@@@@ MARK:- ApiRequest Multipart Data @@@@@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func ApiRequestWithMultipartData<T:Decodable>(baseUrl:String,url:String,images:imageParamArray,parameter: [String:Any],method:HTTPMethod,completion: @escaping (Result<T>) -> ())
       {
           Internet.isAvailable(completion: { (status, message) in
               if status{
                debugPrint("Passed Parameter : \(parameter)")
                debugPrint("url",url,HTTPMethod.self)
                   let req = MultipartdataRequest()
                   req.apiRequest(baseUrl: baseUrl, url: url, method: method, parameter: parameter, multipartData: images, completion: {(response) in
                       completion(response)
                   })
               }
               else{
                   completion(Result<T>.failure(message: message))
               }
           })

       }
    
    
    //-----------------------------------------------------------------------------------
    //@@@@@@@@@@@@@@@@@@@@ MARK:- Configure Request Based on ApiType @@@@@@@@@@@@@@@@@@@@
    //-----------------------------------------------------------------------------------
    
    func configRequest<T:Decodable>(url:String,method:HTTPMethod,parameter:Any,completion: @escaping (Result<T>) -> ())
    {
        
        guard let urlString = URL(string: url) else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppUserdefault.accessToken as String? ?? "")" , forHTTPHeaderField: "Authorization")
        debugPrint("token", AppUserdefault.accessToken as String? ?? "")
        
//        request.addValue("3", forHTTPHeaderField: "User-Type")
        debugPrint("urlString=\(urlString)")
        debugPrint("Headers : \(request.allHTTPHeaderFields) -- \(request.httpMethod)")

        if method == .post || method == .delete || method == .patch || method == .put
        {
            if (!JSONSerialization.isValidJSONObject(parameter as! DictionaryType)) {
                debugPrint("is not a valid json object")
                return
            }
            request.httpBody  = try! JSONSerialization.data(withJSONObject: parameter as! DictionaryType, options:[])
        }
        URLSession.shared.dataTask(with:request ) { (data, response, error) in
            guard let data = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "")
                completion(Result<T>.error(message: "Please try again later"))
                return
            }
            let apiData = (data:data, response:response)
            let model = responseDecode(response: apiData, modelType: T.self)
            completion(model)
            }.resume()
    }
    
}




