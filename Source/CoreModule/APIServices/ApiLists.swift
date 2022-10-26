//
//  ApiLists.swift
//  MyPlans
//
//  Created by macbook  on 11/06/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation
import UIKit

// @@@@@@@@ MARK:- Typealias @@@@@@@@@@

typealias ApiResponse = (status:Status,data:Any,message:String)
typealias ApiData = (data:Data, response:URLResponse?)

enum Result<T:Decodable> {
    case success(data:T) //Success response
    case failure(message:String)//APi call error
    case error(message:String) //Network error
}

enum ApiStatus {
    case NoData
    case NetworkError
    case Success
    case Error
    case Failure
}



// @@@@@@@@ MARK:- Enum @@@@@@@@@@

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum Status{
    case success,failure
}


enum Endpoints:String {

    case register
    case login
    case mobileVerify
    case emailVerify
    case resendMobileOTP
    case resendEmailOTP
    case forgotPassword
    case forgotMobileVerify
    case forgotEmailVerify
    case resetPassword
    case logout
    case aboutUs
    case termsConditions
    case privacy
    case galleryCategory
    case galleryImages
    case homePackageList
    case homeConditionsList
    case testimonial
    case getContactList
    case addContacts
    case packageCalculator
    case packageCalculatorList
    case states
    case city
    case homeBanner

    var rawValue: String{
        switch self {
        case .register:
            return APIBaseURL.base.baseURL + "/user/signup"
        case .login:
            return APIBaseURL.base.baseURL + "/user/login"
        case .mobileVerify:
            return APIBaseURL.base.baseURL + "/otp/mobileOTPVerify"
        case .emailVerify:
            return APIBaseURL.base.baseURL + "/otp/emailOTPVerify"
        case .resendMobileOTP:
            return APIBaseURL.base.baseURL + "/otp/resendMobileOTP"
        case .resendEmailOTP:
            return APIBaseURL.base.baseURL + "/otp/resendEmailOTP"
        case .forgotPassword:
            return APIBaseURL.base.baseURL + "/user/forgotPassword"
        case .forgotMobileVerify:
            return APIBaseURL.base.baseURL + "/otp/forgotPasswordMobileOTPVerify"
        case .forgotEmailVerify:
            return APIBaseURL.base.baseURL + "/otp/forgotPasswordEmailOTPVerify"
        case .resetPassword:
            return APIBaseURL.base.baseURL + "/user/resetPassword"
        case .logout:
            return APIBaseURL.base.baseURL + "/user/logout"
        case .aboutUs:
            return APIBaseURL.cmsAdmin.baseURL + "/cms/cmsPage/AboutusWebLink"
        case .termsConditions:
            return APIBaseURL.cmsAdmin.baseURL + "/cms/cmsPage/termsCondition"
        case .privacy:
            return APIBaseURL.cmsAdmin.baseURL + "/cms/cmsPage/privacyPolicy"
        case .galleryCategory:
            return APIBaseURL.booking.baseURL + "/gallery/categories"
        case .galleryImages:
            return APIBaseURL.booking.baseURL + "/gallery?galleryCategorySlug="
        case .homePackageList:
            return APIBaseURL.booking.baseURL + "/home/packages-list"
        case .homeConditionsList:
            return APIBaseURL.booking.baseURL + "/home/conditions-list"
        case .testimonial:
            return APIBaseURL.base.baseURL + "/testimonial"
        case .getContactList:
            return APIBaseURL.cmsAdmin.baseURL + "/siteSettings/getSiteSettings"
        case .addContacts:
            return APIBaseURL.cmsAdmin.baseURL + "/contactus/add"
        case .packageCalculator:
            return APIBaseURL.booking.baseURL + "/service/getSubChilds"
        case .packageCalculatorList:
            return APIBaseURL.booking.baseURL + "/service/calculate_package"
        case .states:
            return APIBaseURL.booking.baseURL + "/location/states"
        case .city:
            return APIBaseURL.booking.baseURL + "/location/cities?stateId="
        case .homeBanner:
            return APIBaseURL.booking.baseURL + "/home/banner"
        }
    }
    
    // MARK: Stage
    static var stageURL = "http://doodlebluelive.com"
    
    //MARK: Production
//   static var prodURL = "https://manipal.com/api/v1"
     
    // MARK: Dev
    static var devURL = "http://doodlebluelive.com"
    
}

enum APIBaseURL {
    case base
    case booking
    case cmsAdmin
   
    public var baseURL : String {
        switch self {
        case .base:
            return Endpoints.stageURL + APIBaseURL.base.apiVersion
        case .booking:
            return Endpoints.stageURL + APIBaseURL.booking.apiVersion
        case .cmsAdmin:
            return Endpoints.stageURL + APIBaseURL.cmsAdmin.apiVersion
        }
    }
    public var apiVersion : String {
        switch self {
        case .base:
            return ":2194/api/v1"
        case .booking:
            return ":2101/api/v1"
        case .cmsAdmin:
            return ":2102/api/v1"
        }
    }
}

enum StatusCode:Int {
    case success = 200
    case error = 202
    case notFound = 404
    case passError = 403
    case badRequest = 400
    case bad = 503
    case logout = 401
    case noInternet = 0
    case internalServerError = 500
    case badReq = 406
    case userNot = 405
    case profileUpdate = 502
    case profUpdate = 413
    case mobileExist = 422
    case conflict = 409
}

protocol APIResponseDelegate {
    func onSuccess()
    func onFailure(message:String)
}









