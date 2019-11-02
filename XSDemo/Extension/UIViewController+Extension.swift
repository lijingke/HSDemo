//
//  UIViewController+Extension.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
