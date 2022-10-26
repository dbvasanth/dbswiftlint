//
//  LoginViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 27/09/22.
//

import UIKit

class LoginViewModel: NSObject {
    var errMessage = String()
    var successMessage = String()
    
    func apicallForLogin(_ params:LoginRequestModel, completion: @escaping(_ status: ApiStatus, _ data: LoginResponseModelData?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.login.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<LoginResponseModel>) in
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

    func apicallForLogout(completion: @escaping(_ status: ApiStatus, _ data: SimpleResponseModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.logout.rawValue, parameter: [:], method: .get) { (status:Result<SimpleResponseModel>) in
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
