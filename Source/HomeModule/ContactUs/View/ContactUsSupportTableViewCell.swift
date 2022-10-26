//
//  ContactUsSupportTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class ContactUsSupportTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var imageIcon1: UIImageView!
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var valueLabel1: UILabel!
    @IBOutlet weak var imageIcon2: UIImageView!
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var valueLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataInitialization(indexPath: IndexPath,data: ContactUsModelData){
        switch indexPath.row{
        case 0:
            titleLabel.text = "Support"
            valueLabel.text = data.supportEmail ?? ""
            nameLabel1.text = "Marketing -"
            imageIcon.image = UIImage.init(named: "Mail")
            imageIcon1.image = UIImage.init(named: "Mail")
            valueLabel1.text = data.MarketingEmail ?? ""
            nameLabel2.text = "Careers -"
            valueLabel2.text = data.careersEmail ?? ""
            imageIcon2.image = UIImage.init(named: "Mail")
        case 1:
            titleLabel.text = "Office Address"
            nameLabel.text = "Phone No -"
            valueLabel.text = data.office1MobileNumber ?? ""
            imageIcon.image = UIImage.init(named: "Phone")
            nameLabel1.text = "Email address -"
            valueLabel1.text = data.office1Email ?? ""
            imageIcon1.image = UIImage.init(named: "Mail")
            nameLabel2.text = "Address -"
            valueLabel2.text = "\(data.office1Address ?? ""),\(data.office1Country ?? ""),\(data.office1State ?? ""),\(data.office1City ?? "")"
            imageIcon2.image = UIImage.init(named: "Travel")
        default:
            titleLabel.text = "Office Address"
            nameLabel.text = "Phone No -"
            valueLabel.text = data.office2MobileNumber ?? ""
            imageIcon.image = UIImage.init(named: "Phone")
            nameLabel1.text = "Email address -"
            valueLabel1.text = data.office2Email ?? ""
            imageIcon1.image = UIImage.init(named: "Mail")
            nameLabel2.text = "Address -"
            valueLabel2.text = "\(data.office2Address ?? ""),\(data.office2Country ?? ""),\(data.office2State ?? ""),\(data.office2City ?? "")"
            imageIcon2.image = UIImage.init(named: "Travel")
        }
    }
    
}
