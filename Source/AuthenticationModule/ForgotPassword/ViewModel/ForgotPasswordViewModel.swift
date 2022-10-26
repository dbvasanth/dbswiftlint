//
//  ForgotPasswordViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 28/09/22.
//

import UIKit

class ForgotPasswordViewModel: NSObject {
    var errMessage = String()
    var successMessage = String()
    
    func apicallForForgotPassword(_ params:ForgotPasswordRequestModel,completion: @escaping(_ status:ApiStatus,_ data:ForgotPasswordModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.forgotPassword.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<ForgotPasswordModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
    func apicallForForgotPasswordMobileVerify(_ params:ForgotPasswordMobileVeifyRequestModel,completion: @escaping(_ status:ApiStatus,_ data:ForgotPasswordModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.forgotMobileVerify.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<ForgotPasswordModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
    func apicallForForgotPasswordEmailVerify(_ params:ForgotPasswordEmailVeifyRequestModel,completion: @escaping(_ status:ApiStatus,_ data:ForgotPasswordModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.forgotEmailVerify.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<ForgotPasswordModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data)
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
