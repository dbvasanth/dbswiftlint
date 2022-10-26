//
//  DropDownTableViewCell.swift
//  MRM
//
//  Created by siva on 25/08/20.
//  Copyright © 2020 pooja athawale. All rights reserved.
//

import UIKit
import DropDown

class DropDownTableViewCell: DropDownCell,UIPointerInteractionDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewSeperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.4, *) {
            configurePointer()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @available(iOS 13.4, *)
    func configurePointer() {
        let interaction = UIPointerInteraction(delegate: self)
        addInteraction(interaction)
    }
    
    // MARK: - UIPointerInteractionDelegate -
    @available(iOS 13.4, *)
    public func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        var pointerStyle: UIPointerStyle?
        if let interactionView = interaction.view {
            let targetedPreview = UITargetedPreview(view: interactionView)
            pointerStyle = UIPointerStyle(effect: UIPointerEffect.highlight(targetedPreview))
        }
        return pointerStyle
    }
    
}
