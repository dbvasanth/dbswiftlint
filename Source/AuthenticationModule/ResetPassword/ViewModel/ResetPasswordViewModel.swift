//
//  ResetPasswordViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 28/09/22.
//

import UIKit

class ResetPasswordViewModel: NSObject {
    var errMessage = String()
    var successMessage = String()
    
    func apicallForResetPassword(_ params:ResetPasswordRequestModel,completion: @escaping(_ status:ApiStatus,_ data:ResetPasswordModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.resetPassword.rawValue, parameter: params.dictionary ?? [:], method: .post) { (status:Result<ResetPasswordModel>) in
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
