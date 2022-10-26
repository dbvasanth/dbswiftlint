//
//  HomeBannerCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 23/09/22.
//

import UIKit
import SDWebImage

class HomeBannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mobileVIew: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mobileVIew.roundCorners(corners: [.bottomRight, .topRight], radius: 10.0)
    }
    
    func initialization(data: HomeBannerModelData){
        titleLabel.text = data.title ?? ""
        self.bannerImage.sd_setImage(with: URL(string: data.imageUrl ?? ""), placeholderImage: UIImage(named: "appLoginLogo.png"))
    }
    
    @IBAction func bookNowTapped(_ sender: UIButton) {
    }
    

}
