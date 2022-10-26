//
//  GalleryViewController.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionViewGalleryCategory: UICollectionView!
    @IBOutlet weak var collectionViewGalleryImages: UICollectionView!
    
    var viewModel = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.galleryCollectionNib(nameCollection: collectionViewGalleryCategory, imgCollection: collectionViewGalleryImages) {
            self.collectionViewGalleryCategory.delegate = self
            self.collectionViewGalleryCategory.dataSource = self
            self.collectionViewGalleryImages.delegate = self
            self.collectionViewGalleryImages.dataSource = self
            self.apiCallForGalleryList()
        }
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func apiCallForGalleryList() {
        viewModel.apicallForGalleryCategory() { (status, data) in
            if status == .Success {
                self.viewModel.galleryCategoryResponseData = data ?? [GalleryCategoryResponseModelData]()
                if self.viewModel.galleryCategoryResponseData.count != 0 {
                    self.viewModel.getCategoryData {
                        self.collectionViewGalleryCategory.reloadData()
                        self.apiCallForGalleryImages(category: self.viewModel.galleryCategoryData.first?.slug ?? "")
                    }
                }else{
                    self.showToast(message: Message.noData)
                }
            }else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    func apiCallForGalleryImages(category: String) {
        viewModel.apicallForGalleryImages(category: category) { (status, data) in
            if status == .Success {
                self.viewModel.galleryImageResponseData?.imagesUrl?.removeAll()
                self.viewModel.galleryImageResponseData = data
                self.collectionViewGalleryImages.reloadData()
            }else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewGalleryCategory {
            return viewModel.galleryCategoryData.count
        }else{
            return viewModel.galleryImageResponseData?.imagesUrl?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewGalleryCategory {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.GALLERYCATEGORYCELL, for: indexPath) as? GalleryCategoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellConfig(data: viewModel.galleryCategoryData[indexPath.row])
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.GALLERYIMAGESCELL, for: indexPath) as? GalleryImagesCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellConfig(strImage: viewModel.galleryImageResponseData?.imagesUrl?[indexPath.row] ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewGalleryCategory {
            for item in self.viewModel.galleryCategoryData.enumerated(){
                if item.offset == indexPath.row {
                    self.viewModel.galleryCategoryData[indexPath.row].isSelected = true
                    self.apiCallForGalleryImages(category: self.viewModel.galleryCategoryData[indexPath.row].slug ?? "")
                }else{
                    self.viewModel.galleryCategoryData[item.offset].isSelected = false
                }
            }
            self.collectionViewGalleryCategory.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewGalleryCategory {
            let SizeOfString = viewModel.galleryCategoryData[indexPath.row].name?.SizeOfString(font: UIFont(name: "Helvetica Neue Medium", size: 11) ?? UIFont())
            return CGSize(width: SizeOfString?.width ?? 100, height: 32)
        }else{
            return CGSize(width: (collectionView.frame.size.width - 10) / 2, height: 125)
        }
    }
}
