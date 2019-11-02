//
//  DoctorDetailForDoctorProtocol.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/1.
//  Copyright © 2019 李京珂. All rights reserved.
//

import Foundation
import UIKit

protocol DoctorDetailViewForDoctorProtocol: NSObject {
    
    /// 医生资料卡点击加载更多
    func doctorInfoBtnAction(_ sender: UIButton)
    
    /// 医生未开通服务Cell的代理事件
    /// - Parameter btnType: Button类型，1000为开通在线问诊，1001为开通出诊表
    func doctorDidClickOpenService(_ btnType: Int)
  
    /// TableView点击加载更多
    func clickLoadMore(_ sender: UIButton, atSection: Int)

}
