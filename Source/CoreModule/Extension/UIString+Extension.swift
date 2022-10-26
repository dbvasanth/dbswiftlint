//
//  UIString+Extension.swift
//  uGlow
//
//  Created by Doodleblue on 25/08/21.
//

import Foundation
import UIKit

extension String {
    
    func convertDateFormat(currentFormat: String, requiredFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.current.identifier)
        formatter.dateFormat = currentFormat
        if let date = formatter.date(from: self) {
            formatter.dateFormat = requiredFormat
            return formatter.string(from: date)
        }
        return ""
    }
    
    var underLined: NSAttributedString {
        NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func toDate( dateFormat format  : String , isUTC: Bool = true) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = isUTC ? TimeZone(abbreviation: "UTC") : TimeZone(identifier: TimeZone.current.identifier)
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
    func htmlAttributedString(size: CGFloat, color: UIColor) -> NSAttributedString? {
            let htmlTemplate = """
            <!doctype html>
            <html>
              <head>
                <style>
                  body {
                    color: \(color.hexString!);
                    font-family: -apple-system;
                    font-size: \(size)px;
                  }
                </style>
              </head>
              <body>
                \(self)
              </body>
            </html>
            """

            guard let data = htmlTemplate.data(using: .utf8) else {
                return nil
            }

            guard let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
                ) else {
                return nil
            }

            return attributedString
        }
    
    func SizeOfString( font: UIFont) -> CGSize {
            let fontAttribute = [NSAttributedString.Key.font: font]
            let size = self.size(withAttributes: fontAttribute)  // for Single Line
           return size;
        }
   
}
extension UITextView {
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        return text.height(withWidth: width, font: font ?? UIFont())
    }

    func attributedTextHeight(withWidth width: CGFloat) -> CGFloat {
        guard let attributedText = attributedText else {
            return 0
        }
        return attributedText.height(withWidth: width)
    }
}

extension NSAttributedString {
    func height(withWidth width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
        return actualSize.height
    }
}

extension UILabel {
    func addTextSpacing(_ letterSpacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.text!))
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.text!.count)))
        self.attributedText = attributedString
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute

        self.attributedText = attributedString
    }
}

extension UIColor{
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension UITableViewCell{
    func currencyInputFormattingWithoutDecimal(strAmount: String) -> String {
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.currencySymbol = ""
            formatter.numberStyle = .currencyAccounting
            return formatter.string(from: NSNumber(value: (strAmount as NSString).doubleValue)) ?? ""
        }
}
