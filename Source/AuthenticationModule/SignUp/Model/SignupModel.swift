//
//  SignupModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 23/09/22.
//

import Foundation

struct SignupRequestModel: Codable {
    var name: String?
    var dob: String?
    var mobileNumber: String?
    var emailId: String?
    var password: String?
    var platformType : String?
}

struct MobileVeifyRequestModel: Codable{
    var mobileNumber : String?
    var mobileOTP : String?
}

struct EmailVeifyRequestModel: Codable{
    var emailId : String?
    var emailOTP : String?
    var deviceToken : String? = ""
}

struct ResendMobileOTPRequestModel: Codable{
    var mobileNumber : String?
}

struct ResendEmailOTPRequestModel: Codable{
    var emailId : String?
}

struct SignupResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: SignupResponseModelData?
}

struct SignupResponseModelData: Codable {
    let registerStatus: Int?
    let emailId, countryCode, mobileNumber: String?
    let name, gender, dob, password: String?
    let profilePic, defaultCity, defaultPincode, defaultState: String?
    let defaultLongitude, defaultLatitude: Double?
    let token: String?
}

struct SimpleResponseModel: Codable {
    let status: Int?
    let message: String?
}
