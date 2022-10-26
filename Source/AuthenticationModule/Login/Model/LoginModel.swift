//
//  LoginModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 27/09/22.
//

import Foundation

struct LoginRequestModel : Codable{
    var emailId : String?
    var password : String?
    var platformType : String?
    var deviceToken : String? = ""
}

struct LoginResponseModel : Codable{
    var status: Int?
    var message: String?
    var data: LoginResponseModelData?
}

struct LoginResponseModelData: Codable {
    let registerStatus: Int?
    let emailId, countryCode, mobileNumber: String?
    let name, gender, dob, password: String?
    let profilePic, defaultCity, defaultPincode, defaultState: String?
    let defaultLongitude, defaultLatitude: Double?
    let token: String?
}

