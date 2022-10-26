//
//  ForgotPasswordModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 28/09/22.
//

import Foundation

struct ForgotPasswordModel: Codable {
    var status: Int?
    var message: String?
}

struct ForgotPasswordRequestModel: Codable {
    var mobileNumber : String?
    var emailId : String?
}

struct ForgotPasswordMobileVeifyRequestModel: Codable {
    var mobileNumber : String?
    var mobileOTP : String?
}

struct ForgotPasswordEmailVeifyRequestModel: Codable {
    var emailId : String?
    var emailOTP : String?
}
