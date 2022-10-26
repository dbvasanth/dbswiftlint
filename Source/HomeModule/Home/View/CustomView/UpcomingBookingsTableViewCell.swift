//
//  UpcomingBookingsTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 23/09/22.
//

import UIKit

class UpcomingBookingsTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var packageNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountPaidStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.applySketchShadow(color: .white, alpha: 0.15, x: 0, y: 4, blur: 15, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
