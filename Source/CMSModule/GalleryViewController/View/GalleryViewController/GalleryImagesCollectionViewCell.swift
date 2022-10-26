//
//  GalleryImagesCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import UIKit
import SDWebImage

class GalleryImagesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgViewGallery: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellConfig(strImage: String){
        DispatchQueue.main.async {
            self.imgViewGallery.sd_setImage(with: URL(string: strImage), placeholderImage: UIImage(named: "logoImg"))
        }
    }

}
