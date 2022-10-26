//
//  UIButton+Extension.swift
//  uGlow
//
//  Created by DB-IM-008 on 17/09/21.
//

import UIKit
extension UIButton {
//    @IBInspectable
//       var letterSpacing: CGFloat {
//           set {
//               let attributedString: NSMutableAttributedString
//               if let currentAttrString = attributedTitle(for: .normal) {
//                   attributedString = NSMutableAttributedString(attributedString: currentAttrString)
//               }
//               else {
//                   attributedString = NSMutableAttributedString(string: self.title(for: .normal) ?? "")
//                   setTitle(.none, for: .normal)
//               }
//
//               attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
//               setAttributedTitle(attributedString, for: .normal)
//           }
//           get {
//               if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
//                   return currentLetterSpace
//               }
//               else {
//                   return 0
//               }
//           }
//       }
    func addTextSpacing(_ letterSpacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
