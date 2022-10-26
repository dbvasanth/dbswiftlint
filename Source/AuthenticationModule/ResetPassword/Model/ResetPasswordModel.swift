//
//  ResetPasswordModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 28/09/22.
//

import Foundation

struct ResetPasswordModel: Codable{
    var status: Int?
    var message: String?
}

struct ResetPasswordRequestModel: Codable {
    var emailId: String?
    var password: String?
    var confirmPassword : String?
}
