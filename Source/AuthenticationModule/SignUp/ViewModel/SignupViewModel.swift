//
//  SignupViewModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 23/09/22.
//

import Foundation
import UIKit

class SignupViewModel: NSObject {
    var errMessage = String()
    var successMessage = String()

    func apicallForRegister(_ params:SignupRequestModel,completion: @escaping(_ status:ApiStatus,_ data:SignupResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.register.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<SignupResponseModel>) in
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
    
    func apicallForMobileVerifyOTP(_ params:MobileVeifyRequestModel,completion: @escaping(_ status:ApiStatus,_ data:SignupResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.mobileVerify.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<SignupResponseModel>) in
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
    
    func apicallForEmailVerifyOTP(_ params:EmailVeifyRequestModel,completion: @escaping(_ status:ApiStatus,_ data:SignupResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.emailVerify.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<SignupResponseModel>) in
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
    
    func apicallForResendMobileOTP(_ params:ResendMobileOTPRequestModel,completion: @escaping(_ status:ApiStatus,_ data:SimpleResponseModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.resendMobileOTP.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<SimpleResponseModel>) in
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
    
    func apicallForResendEmailOTP(_ params:ResendEmailOTPRequestModel,completion: @escaping(_ status:ApiStatus,_ data:SimpleResponseModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.resendEmailOTP.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<SimpleResponseModel>) in
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
