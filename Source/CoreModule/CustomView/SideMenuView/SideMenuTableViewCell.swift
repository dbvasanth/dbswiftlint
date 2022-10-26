//
//  SideMenuTableViewCell.swift
//  uGlow
//
//  Created by Doodleblue on 02/08/21.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigureSideMenu(data: SideMenu?) {
        if let param = data {
            lblTitle.text = param.title
            imgViewIcon.image = param.image
        }
    }
    
}
