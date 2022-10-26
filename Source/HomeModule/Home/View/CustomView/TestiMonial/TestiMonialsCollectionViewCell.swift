//
//  TestiMonialsCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class TestiMonialsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialization(data: HomeTestimonialListDataList){
        nameLabel.text = data.userDetails?.name ?? ""
        self.userImage.sd_setImage(with: URL(string: data.userDetails?.profilePic ?? ""), placeholderImage: UIImage(named: "appLoginLogo.png"))
        locationLabel.text = data.userDetails?.defaultCity ?? ""
        descriptionLabel.text = data.comments ?? ""
    }

}
