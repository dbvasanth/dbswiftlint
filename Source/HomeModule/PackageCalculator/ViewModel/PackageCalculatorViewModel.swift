//
//  PackageCalculatorViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class PackageCalculatorViewModel: NSObject {
    var errMessage = String()
    
    func apicallForCalculatePackage(completion: @escaping(_ status:ApiStatus,_ data:PackageCalculatorModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.packageCalculator.rawValue, parameter:[:], method: .post) { (status:Result<PackageCalculatorModel>) in
            switch status{
            case .success(let data):
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
    func apicallForPackageCalculatorList(completion: @escaping(_ status:ApiStatus,_ data:PackageCalculatorList?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.packageCalculator.rawValue, parameter:[:], method: .post) { (status:Result<PackageCalculatorList>) in
            switch status{
            case .success(let data):
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
