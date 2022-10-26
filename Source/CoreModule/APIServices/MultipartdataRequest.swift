//
//  MultipartdataRequest.swift
//  MyPlans
//
//  Created by macbook  on 11/06/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation
import UIKit

let ApiMultipartRequest = MultipartdataRequest.sharedInstance
typealias imageParamArray = [(key:String,image:Data)]

class MultipartdataRequest:NSObject{
    static let sharedInstance:MultipartdataRequest = {
        let instance = MultipartdataRequest()
        return instance
    }()
    
    func apiRequest<T:Decodable>(baseUrl:String,url:String,method:HTTPMethod,parameter:Any,multipartData:imageParamArray,completion:@escaping(Result<T>) ->())
    {
        debugPrint("Method",method)
        
        
        guard let urlString = URL(string: baseUrl + url) else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        request.addValue("Bearer " + (AppUserdefault.accessToken ?? ""), forHTTPHeaderField: "Authorization")
//        request.addValue("2", forHTTPHeaderField: "platform")

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let data  = createBody(url:url,parameters: parameter as! [String : Any],boundary: boundary,images: multipartData,mimeType: "image/jpeg")
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task: URLSessionUploadTask = session.uploadTask(with: request, from: data){ (data,response,error) in
            guard let data = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "")
                return
            }
            let apiData = (data:data, response:response)
            let model = responseDecode(response: apiData, modelType: T.self) //Get response of respective model class
            completion(model)
            //completion(responsee(response:(data:data, response:response)))
        }
        task.resume()
    }
    
    
    //----------------------------------------------------------------------------
    //  @@@@@@@@@@ MARK:- Binding Multipart Data with parameters @@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func createBody(url:String,parameters: [String: Any],boundary: String,images:imageParamArray,mimeType: String) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in parameters
        {
            
            if let arrayObj = value as? [String]{
                let count : Int  = arrayObj.count
                for i in 0  ..< count
                {
                    let valueObj = arrayObj[i]
                    
                    let keyObj = key + "[" + String(i) + "]"
                    body.appendString(string: boundaryPrefix)
                    body.appendString(string:  "Content-Disposition: form-data; name=\"\(keyObj)\"\r\n\r\n")
                    body.appendString(string: "\(valueObj)\r\n")
                    
                }
            }else{
                body.appendString(string: boundaryPrefix)
                body.appendString(string:  "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                
                body.appendString(string: "\(value)\r\n")
            }
        }
        //DispatchQueue.concurrentPerform(iterations: images.count) { index in
        for value in images
        {
//            if let imageData = value.image.jpegData(compressionQuality: 0.5)
//            {
                let keyName = value.key
                let filename = keyName + ".jpeg"
                body.appendString(string: boundaryPrefix)
                body.appendString(string: "Content-Disposition: form-data; name=\"\(keyName)\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimeType)\r\n\r\n")
                body.append(value.image)
                body.appendString(string: "\r\n")
//            }
        }
        body.appendString(string: "--".appending(boundary.appending("--")).appending("\r\n"))
        return body as Data
    }
}

//--------------------------------------------------------------------------------------
//  @@@@@@@@@@ MARK:- URLSESSION DELEGATE (UPLOAD & DOWNLOAD PROGRESS) @@@@@@@@@@@@@@@@@
//--------------------------------------------------------------------------------------

extension MultipartdataRequest:URLSessionDelegate,URLSessionDataDelegate,URLSessionTaskDelegate{
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
    {
        debugPrint("didCompleteWithError")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
    {
        debugPrint("didSendBodyData",session,task.taskIdentifier,session.sessionDescription)
        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        let progressPercent = Int(uploadProgress*100)  // Progress Shown Here
        debugPrint(progressPercent)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
    {
        debugPrint("didReceiveResponse")
        debugPrint(response)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
    {
        debugPrint("didReceiveData")
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, .none)
    }
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

func convertIntoJSONString(arrayObject: [String]) -> String? {
    
    do {
        let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
        if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
            return jsonString as String
        }
        
    } catch let error as NSError {
        debugPrint("Array convertIntoJSON - \(error.description)")
    }
    return nil
}

