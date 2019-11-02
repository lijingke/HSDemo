//
//  String+Extension.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

extension String {
    
    /// 改变字符串中数字的颜色和字体
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - font: 字体
    ///   - regx: 正则 默认数字 "\\d+"
    /// - Returns: attributeString
    
    
    
    func modifyNumberColor(color: UIColor,
                           font: UIFont,
                           regx: String = "([0-9]\\d*\\.?\\d*)") -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        do {
            // 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: regx, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    [.foregroundColor : color, .font: font],
                    range: item.range
                )
            }
        } catch {
            print("Failed with error: \(error)")
        }
        return attributeString
    }
}
