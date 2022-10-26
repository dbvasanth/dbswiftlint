//
//  HealthPackageCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 26/09/22.
//

import UIKit

class HealthPackageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var packageNameLabel: UILabel!
    @IBOutlet weak var offerAmountLabel: UILabel!
    @IBOutlet weak var originalAmountLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.applySketchShadow(color: .white, alpha: 0.15, x: 0, y: 4, blur: 15, spread: 0)
    }
    
    func initialization(data: HomePackageListData){
        packageNameLabel.text = data.name ?? ""
        self.image.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage: UIImage(named: "appLoginLogo.png"))
        offerAmountLabel.text = "₹ \(data.discountPrice ?? 0)"
        let offerValue = "₹ \(data.originalprice ?? 0)"
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: offerValue)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: offerValue.count, range: NSRange(location: 0, length: attributeString.length))
        originalAmountLabel.attributedText = attributeString
    }
    
    @IBAction func bookNowTapped(_ sender: UIButton) {
    }
    

}
