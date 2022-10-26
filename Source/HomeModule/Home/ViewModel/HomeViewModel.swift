//
//  HomeViewModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 29/09/22.
//

import UIKit

class HomeViewModel: NSObject {
    var errMessage = String()

    func apicallForBannerList(_ url: String,completion: @escaping(_ status:ApiStatus,_ data:HomeBannerModel?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.homeBanner.rawValue)\(url)", parameter:[:], method: .get) { (status:Result<HomeBannerModel>) in
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
    func apicallForPackageList(_ url: String,completion: @escaping(_ status:ApiStatus,_ data:HomePackageList?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.homePackageList.rawValue)\(url)", parameter:[:], method: .get) { (status:Result<HomePackageList>) in
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
    func apicallForConditionList(_ url: String,completion: @escaping(_ status:ApiStatus,_ data:HomeConditiosList?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.homeConditionsList.rawValue)\(url)", parameter:[:], method: .get) { (status:Result<HomeConditiosList>) in
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
    func apicallForTestimonialList(_ url: String,completion: @escaping(_ status:ApiStatus,_ data:HomeTestimonialList?) -> ()){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.testimonial.rawValue)\(url)", parameter:[:], method: .get) { (status:Result<HomeTestimonialList>) in
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
