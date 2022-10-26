//
//  ValidateResponse.swift
//  MyPlans
//
//  Created by macbook  on 11/06/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation


typealias DictionaryType = [String:Any]


//----------------------------------------------------------------------------
//  @@@@@@@@@@ MARK:- VALIDATE RESPONSE DATA @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//----------------------------------------------------------------------------


 func responseDecode<T:Decodable>(response:ApiData,modelType:T.Type)-> Result<T>{
    //Decode the response to respective model class
     var dict = DictionaryType()
     var message = ""
    if let httpResponse = response.1 as? HTTPURLResponse
    {
        
        let code:Int = httpResponse.statusCode
        if let status = StatusCode(rawValue: code){
        
        let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String:Any]
       
        if let messageValue = json?["message"] as? String{
            message = messageValue
            debugPrint(json)
        }
        
        switch status{
        case .success:
            do{
            let model = try JSONDecoder().decode(modelType.self, from: response.data)
            return Result<T>.success(data: model)
            }catch (let error){
                debugPrint(error)
            }
        case .error:
            return Result<T>.error(message: message)
        case .notFound:
            return Result<T>.failure(message: message)
        case .badRequest:
            return Result<T>.failure(message: message)
        case .bad:
            return Result<T>.failure(message: message)
        case .logout:
            return Result<T>.failure(message: message)
        case .noInternet:
            return Result<T>.failure(message: message)
        case .internalServerError:
            return Result<T>.failure(message: message)
        case .passError:
            return Result<T>.failure(message: message)
        case .badReq:
            return Result<T>.failure(message: message)
        case .userNot:
            return Result<T>.failure(message: message)
        case .profileUpdate:
            return Result<T>.failure(message: message)
        case .profUpdate:
            return Result<T>.failure(message: message)
        case .mobileExist:
             return Result<T>.failure(message: message)
        case .conflict:
             return Result<T>.failure(message: message)
            }
        }
        else{
          return Result<T>.failure(message: message)
        }
    }
    return Result<T>.failure(message: message)

}



