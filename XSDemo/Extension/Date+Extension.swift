//
//  Date+Extension.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/5.
//  Copyright © 2019 李京珂. All rights reserved.
//

import Foundation

extension Date {
    public func stringWithFormat(format:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
