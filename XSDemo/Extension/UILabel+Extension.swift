//
//  UILabel+Extension.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/4.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// UILabel根据文字的需要的高度
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// UILabel根据文字实际的行数
    public var lines: Int {
        return Int(requiredHeight / font.lineHeight)
    }
}

extension UILabel {
    func getLinesArrayOfString() -> [String]? {
        let text = self.text
        let font = self.font
        let rect = self.frame

        let myFont = CTFontCreateWithName(((font?.fontName) as CFString?)!, font!.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text ?? "")
        attStr.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: myFont, range: NSRange(location: 0, length: attStr.length))
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width , height: 100000), transform: .identity)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(frame) as? [AnyHashable]
        var linesArray: [AnyHashable] = []
        for line in lines ?? [] {
            let lineRef = line
            let lineRange = CTLineGetStringRange(lineRef as! CTLine)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString = (text as NSString?)?.substring(with: range)
            CFAttributedStringSetAttribute(attStr as CFMutableAttributedString, lineRange, kCTKernAttributeName, (NSNumber(value: 0.0)))
            linesArray.append(lineString ?? "")
        }
        return linesArray as? [String]
    }
}
