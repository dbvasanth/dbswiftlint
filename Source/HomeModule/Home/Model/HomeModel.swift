//
//  HomeModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 29/09/22.
//

import Foundation

struct HomeBannerModel : Codable{
    var status : Int?
    var message : String?
    var data : [HomeBannerModelData]?
}
struct HomeBannerModelData : Codable{
    var _id : String?
    var packageId : String?
    var title : String?
    var description : String?
    var imageUrl : String?
    var link : String?
    var linkText : String?
    var status : String?
    var cityId : String?
    var stateId : String?
    var pincode : String?
    var createdAt : String?
    var updatedAt : String?
    var packageDetails : HomeBannerModelPackageDetails?
}
struct HomeBannerModelPackageDetails : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var description : String?
    var image : String?
    var categoriesId : [String]?
    var subCategoriesId : [String]?
    var conditionsId : [String]?
    var subChildCategoriesId : [String]?
    var discountType : String?
    var discountRate : Int?
    var discountPrice : Int?
    var isDiscount : Bool?
    var cityId : String?
    var stateId : String?
    var pincode : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
}

struct HomePackageList : Codable{
    var status : Int?
    var message : String?
    var data : [HomePackageListData]?
}
struct HomePackageListData : Codable{
    var image : String?
    var name : String?
    var originalprice : Int?
    var discountPrice : Int?
}
struct HomeConditiosList : Codable{
    var status : Int?
    var message : String?
    var data : [HomeConditiosListData]?
}
struct HomeConditiosListData: Codable{
    var image : String?
    var status : String?
    var _id : String?
    var name : String?
    var slug : String?
    var createdAt : String?
    var updatedAt : String?
}
struct HomeTestimonialList : Codable{
    var status : Int?
    var message : String?
    var data : HomeTestimonialListData?
}
struct HomeTestimonialListData: Codable{
    var list : [HomeTestimonialListDataList]?
    var pageMeta : PageMeta?
}
struct HomeTestimonialListDataList : Codable{
    var _id : String?
    var userId : String?
    var comments : String?
    var platformType : String?
    var status : String?
    var createdBy : String?
    var updatedBy : String?
    var userDetails : UserDetails?
}
struct PageMeta : Codable{
    var size : Int?
    var page : Int?
    var total : Int?
    var totalPages : Int?
}
struct UserDetails : Codable{
    var _id : String?
    var platformType : String?
    var userType : Int?
    var loginMethod : String?
    var isEmailVerified : Bool?
    var isMobileNoVerified : Bool?
    var status : String?
    var registerStatus : Int?
    var emailId : String?
    var countryCode : String?
    var mobileNumber : String?
    var name : String?
    var gender : String?
    var dob : String?
    var password : String?
    var profilePic : String?
    var defaultCity : String?
    var defaultPincode : String?
    var defaultState : String?
    var defaultLongitude : Double?
    var defaultLatitude : Double?
    var createdAt : String?
    var updatedAt : String?
    var __v : Int?
    var createdBy : String?
    var updatedBy : String?
}
