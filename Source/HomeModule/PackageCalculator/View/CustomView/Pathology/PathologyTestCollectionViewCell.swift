//
//  PathologyTestCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 03/10/22.
//

import UIKit

class PathologyTestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dataInitialization(data: PackageCalculatorModelDataInnercategory){
        nameLabel.text = data.name ?? ""
    }

}
