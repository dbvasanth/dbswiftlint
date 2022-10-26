//
//  UISlider+Extension.swift
//  uGlow
//
//  Created by Doodleblue on 16/08/21.
//

import Foundation
import UIKit

extension UISlider {
    func setThumbValueWithLabel(rightPaddingValue: Int) -> CGPoint {
        let slidertTrack : CGRect = self.trackRect(forBounds: self.bounds)
        let sliderFrm : CGRect = self.thumbRect(forBounds: self.bounds, trackRect: slidertTrack, value: self.value)
        return CGPoint(x: sliderFrm.origin.x + self.frame.origin.x + CGFloat(rightPaddingValue), y: self.frame.origin.y + 55)
    }
}
