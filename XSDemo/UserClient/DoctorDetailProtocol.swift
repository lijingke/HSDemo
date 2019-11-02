//
//  DoctorDetailProtocol.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/10/29.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import Foundation
import UIKit

protocol DoctorDetailViewProtocol: NSObject {
    
    /// 医生资料卡点击加载更多
    func doctorInfoBtnAction(_ sender: UIButton)
    
    /// TableView点击加载更多
    func clickLoadMore(_ sender: UIButton, atSection: Int)
    
    /// 随访包点击事件
    func followUpPackageBtnAction(_ sender: UIButton, entity: FollowUpPackageEntity)
    
    /// 点击咨询时的代理事件
    func didClickConsultBtn(_ entity: FollowUpPackageEntity)
    
}
