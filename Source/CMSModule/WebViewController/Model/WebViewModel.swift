//
//  WebViewModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import Foundation

struct AboutUsResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: AboutUsResponseModelData?
}

struct AboutUsResponseModelData: Codable {
    let webPageLink: String?
}

struct WebViewResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: WebViewResponseModelData?
}

struct WebViewResponseModelData: Codable {
    let cmsContent: CMSContentData?
}

struct CMSContentData: Codable {
    let description: String?
}
