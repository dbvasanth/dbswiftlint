//
//  TestConditionCollectionViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 26/09/22.
//

import UIKit

class TestConditionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.applySketchShadow(color: .white, alpha: 0.15, x: 0, y: 4, blur: 15, spread: 0)
    }

    func initialization(data: HomeConditiosListData){
        nameLabel.text = data.name ?? ""
        self.image.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage: UIImage(named: "appLoginLogo.png"))
    }
}
