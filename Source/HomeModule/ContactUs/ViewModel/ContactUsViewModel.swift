//
//  ContactUsViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class ContactUsViewModel: NSObject {
    var errMessage = String()
    var successErrorMessage = String()
    
    func apicallForGetContactList(completion: @escaping(_ status:ApiStatus,_ data:ContactUsModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.getContactList.rawValue)", parameter:[:], method: .get) { (status:Result<ContactUsModel>) in
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

    func apicallForAddContactList(_ params:ContactRequestModel,completion: @escaping(_ status:ApiStatus,_ data:AddContacts?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.addContacts.rawValue)", parameter:params.dictionary ?? [:], method: .post) { (status:Result<AddContacts>) in
            switch status{
            case .success(let data):
                self.successErrorMessage = data.message ?? ""
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
    
    func apicallForGetStateList(completion: @escaping(_ status:ApiStatus,_ data:StateModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.states.rawValue)", parameter:[:], method: .get) { (status:Result<StateModel>) in
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
    
    func apicallForGetCityList(_ stateId:String,completion: @escaping(_ status:ApiStatus,_ data:CityModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.city.rawValue)\(stateId)", parameter:[:], method: .get) { (status:Result<CityModel>) in
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
