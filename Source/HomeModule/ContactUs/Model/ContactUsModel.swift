//
//  ContactUsModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import Foundation

struct ContactUsModel : Codable{
    var status : Int?
    var message : String?
    var data : ContactUsModelData?
}
struct ContactUsModelData : Codable{
    var status : Int?
    var _id : String?
    var name : String?
    var office1MobileNumber : String?
    var office1Email : String?
    var office1Address : String?
    var office1City : String?
    var office1State : String?
    var office1Pincode : Int?
    var office1Country : String?
    var office2MobileNumber : String?
    var office2Email : String?
    var office2Address : String?
    var office2City : String?
    var office2State : String?
    var office2Pincode : Int?
    var office2Country : String?
    var supportEmail : String?
    var MarketingEmail : String?
    var careersEmail : String?
    var description : String?
    var socialLinks : [SocialLinks]?
    var taxChargeAmount : Int?
}
struct SocialLinks : Codable{
    var _id : String?
    var name : String?
    var link : String?
    var linkType : String?
}
struct AddContacts : Codable{
    var status : Int?
    var message : String?
    var data : AddContactsData?
}
struct AddContactsData : Codable{
    var _id : String?
    var name : String?
    var email : String?
    var phoneNumber : String?
    var stateId : String?
    var cityId : String?
    var message : String?
}
struct ContactRequestModel : Codable{
    var name : String?
    var email : String?
    var phoneNumber : String?
    var stateId : String?
    var cityId : String?
    var message : String?
}
struct StateModel : Codable{
    var status : Int?
    var message : String?
    var data : [StateModelData]?
}
struct StateModelData : Codable{
    var _id : String?
    var stateName : String?
    var __v : Int?
    var country_id : Int?
    var createdAt : String?
    var stateNameSlug : String?
    var updatedAt : String?
    var state_id : String?
}
struct CityModel : Codable{
    var status : Int?
    var message : String?
    var data : [CityModelData]?
}
struct CityModelData : Codable{
    var _id : String?
    var cityName : String?
    var __v : Int?
    var cityslug : String?
    var createdAt : String?
    var stateId : String?
    var updatedAt : String?
}
