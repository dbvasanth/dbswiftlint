//
//  UITextField+Extension.swift
//  uGlow
//
//  Created by sandhya on 23/08/21.
//

import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = String(t?.prefix(maxLength) ?? "")
    }
  
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    @IBInspectable
          var letterSpace: CGFloat {
              set {
                  let attributedString: NSMutableAttributedString!
                  if let currentAttrString = attributedText {
                      attributedString = NSMutableAttributedString(attributedString: currentAttrString)
                  }
                  else {
                      attributedString = NSMutableAttributedString(string: text ?? "")
                      text = nil
                  }

               attributedString.addAttribute(NSAttributedString.Key.kern,
                                                 value: newValue,
                                                 range: NSRange(location: 0, length: attributedString.length))

                  attributedText = attributedString
              }

              get {
               if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                      return currentLetterSpace
                  }
                  else {
                      return 0
                  }
              }
          }

}
