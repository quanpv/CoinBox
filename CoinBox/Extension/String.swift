//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.count
    }
    
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraph.lineBreakMode = lineBreakMode
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paragraph], context: nil)
        
        return boundingBox.height
    }
    
    func heightWithSpacing(withConstrainedWidth width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode, spacing: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraph.lineSpacing = spacing
        paragraph.lineBreakMode = lineBreakMode
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paragraph], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraph.lineBreakMode = lineBreakMode
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paragraph], context: nil)
        
        return boundingBox.width
    }
    
    var toDecimal: NSDecimalNumber {
        return NSDecimalNumber(string: self)
    }
    
    func toDouble() -> Double?{
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var isValidDec: Bool {
        return self.toDecimal.compare(NSDecimalNumber.notANumber) != ComparisonResult.orderedSame
    }
}

extension NSDecimalNumber {
    func round(digit: Int16, mode: NSDecimalNumber.RoundingMode) -> NSDecimalNumber {
        let behavior = NSDecimalNumberHandler(roundingMode: mode, scale: digit, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return self.rounding(accordingToBehavior: behavior)
    }
}
