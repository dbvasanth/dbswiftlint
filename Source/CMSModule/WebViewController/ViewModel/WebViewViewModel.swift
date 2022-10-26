//
//  WebViewViewModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import Foundation
import UIKit

class WebViewViewModel: NSObject {
    var errMessage = String()
    var successMessage = String()

    func apicallForAboutUs(completion: @escaping(_ status:ApiStatus,_ data:AboutUsResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.aboutUs.rawValue, parameter: [:], method: .get) { (status:Result<AboutUsResponseModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data.data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
    func apicallForTermsConditions(completion: @escaping(_ status:ApiStatus,_ data:WebViewResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.termsConditions.rawValue, parameter: [:], method: .get) { (status:Result<WebViewResponseModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data.data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
    func apicallForPrivacy(completion: @escaping(_ status:ApiStatus,_ data:WebViewResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.privacy.rawValue, parameter: [:], method: .get) { (status:Result<WebViewResponseModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data.data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
}
