//
//  GalleryCategoriesCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MBP-008 on 07/10/22.
//

import UIKit

class GalleryCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellConfig(data: GalleryCategoryModel){
        viewBackground.backgroundColor = data.isSelected ?? false ? UIColor(red: 0.01, green: 0.31, blue: 0.63, alpha: 1.00) : UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.00)
        lblCategory.textColor = data.isSelected ?? false ? UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00) : UIColor(red: 0.01, green: 0.31, blue: 0.63, alpha: 1.00)
        lblCategory.text = data.name
        
    }
}

