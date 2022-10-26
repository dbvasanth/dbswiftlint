//
//  UITableView+Extension.swift
//  uGlow
//
//  Created by Doodleblue on 27/08/21.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String, notificationTable: Bool) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = notificationTable ? #colorLiteral(red: 0.1570051014, green: 0.1588717997, blue: 0.2081049681, alpha: 1)  :  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Brown-Bold", size: 16)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
