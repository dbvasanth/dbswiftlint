//
//  GalleryModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import Foundation

struct GalleryCategoryModel {
    var name: String?
    var slug: String?
    var isSelected: Bool?
}

struct GalleryCategoryResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: [GalleryCategoryResponseModelData]?
}

struct GalleryCategoryResponseModelData: Codable {
    let name: String?
    let slug: String?
}

struct GalleryImageResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: GalleryImageResponseModelData?
}

struct GalleryImageResponseModelData: Codable {
    var imagesUrl: [String]?
}
