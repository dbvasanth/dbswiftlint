//
//  PackageCalculatorModel.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import Foundation

struct PackageCalculatorModel : Codable{
    var status : Int?
    var message : String?
    var data : [PackageCalculatorModelData]?
}
struct PackageCalculatorModelData : Codable{
    var _id : String?
    var name : String?
    var subcategory : [PackageCalculatorModelDataSubcategory]?
}
struct PackageCalculatorModelDataSubcategory : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var categoryId : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
    var isSelected : Bool?
    var innercategory : [PackageCalculatorModelDataInnercategory]?
}
struct PackageCalculatorModelDataInnercategory : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var categoryId : String?
    var status : String?
    var price : Int?
    var createdAt : String?
    var updatedAt : String?
    var subCategoryId : String?
    var conditionsId : [String]?
    var code : String?
    var cutOffTime : String?
    var method : String?
    var reportAvailability : String?
    var specimen : String?
    var pincode : String?
    var description : String?
}

struct PackageCalculatorList : Codable{
    var status : Int?
    var message : String?
    var data : PackageCalculatorListData?
}
struct PackageCalculatorListData : Codable{
    var list : [PackageCalculatorListDataList]?
    var pageMeta : PageMeta?
}
struct PackageCalculatorListDataList : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var description : String?
    var image : String?
    var discountType : String?
    var discountRate : Int?
    var isDiscount : Bool?
    var pincode : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
    var cityId : String?
    var categoriesId : [String]?
    var subCategoriesId : [String]?
    var conditionsId : [String]?
    var cityDetails : CityDetails?
    var stateDetails : StateDetails?
    var reportTime : String?
    var fastingTime : String?
    var additionalDescription : String?
    var categoryDetails : [PCListCategoryDetails]?
    var subcategoryDetails : [PCListSubcategoryDetails]?
    var subchildcategoryDetails : [PCListSubchildcategoryDetails]?
    var conditionDetails : [ConditionDetails]?
    var originalPrice : Int?
    var discountPrice : Int?
    var deductedAmount : Int?
}
struct CityDetails : Codable{
    var _id : String?
    var stateId : String?
    var cityName : String?
    var cityslug : String?
    var createdAt : String?
    var updatedAt : String?
}
struct StateDetails : Codable{
    var _id : String?
    var stateName : String?
    var stateNameSlug : String?
    var country_id : Int?
    var createdAt : String?
    var updatedAt : String?
    var state_id : String?
}
struct ConditionDetails: Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
}
struct PCListCategoryDetails : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
}
struct PCListSubcategoryDetails : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var categoryId : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
}
struct PCListSubchildcategoryDetails : Codable{
    var _id : String?
    var name : String?
    var slug : String?
    var image : String?
    var categoryId : String?
    var subCategoryId : String?
    var status : String?
    var price : Int?
    var createdAt : String?
    var updatedAt : String?
}
