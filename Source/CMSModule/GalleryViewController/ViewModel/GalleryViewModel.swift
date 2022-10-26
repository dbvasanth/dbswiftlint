//
//  GalleryViewModel.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import Foundation
import UIKit

class GalleryViewModel:NSObject{
    
    var errMessage = String()
    var successMessage = String()
    var galleryCategoryResponseData = [GalleryCategoryResponseModelData]()
    var galleryCategoryData = [GalleryCategoryModel]()
    var galleryImageResponseData : GalleryImageResponseModelData?
    
    func galleryCollectionNib(nameCollection: UICollectionView, imgCollection: UICollectionView, completion: @escaping() -> ()) {
        nameCollection.register(UINib(nibName: CollectionViewCell.GALLERYCATEGORYCELL, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.GALLERYCATEGORYCELL)
        imgCollection.register(UINib(nibName: CollectionViewCell.GALLERYIMAGESCELL, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.GALLERYIMAGESCELL)
        completion()
    }
    
    func getCategoryData(completion: () -> Void){
        for item in galleryCategoryResponseData.enumerated() {
            if item.offset == 0 {
                galleryCategoryData.append(GalleryCategoryModel(name: item.element.name, slug: item.element.slug, isSelected: true))
            }else{
                galleryCategoryData.append(GalleryCategoryModel(name: item.element.name, slug: item.element.slug, isSelected: false))
            }
        }
        completion()
    }
    
    func apicallForGalleryCategory(completion: @escaping(_ status:ApiStatus, _ data: [GalleryCategoryResponseModelData]?) -> ()) {
        ApiRequest.sharedInstance.apiRequest(url: Endpoints.galleryCategory.rawValue, parameter: [:], method: .get) { (status:Result<GalleryCategoryResponseModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data.data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
    func apicallForGalleryImages(category: String, completion: @escaping(_ status:ApiStatus, _ data: GalleryImageResponseModelData?) -> () ){
        ApiRequest.sharedInstance.apiRequest(url: "\(Endpoints.galleryImages.rawValue)\(category)", parameter: [:], method: .get) { (status:Result<GalleryImageResponseModel>) in
            switch status{
            case .success(let data):
                self.successMessage = data.message ?? ""
                completion(.Success,data.data)
            case .failure(let message):
                self.errMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errMessage = message
                completion(.Error,nil)
            }
        }
    }
    
}
