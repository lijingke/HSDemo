//
//  DoctorDetail.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/10/28.
//  Copyright © 2019 李京珂. All rights reserved.
//

import Foundation
import UIKit

/// 我与医生界面数据模型
struct DoctorWithMeEntity {
    
    var followUpPkgs: [FollowUpPackageEntity] = []
    
    var articles: [ArticleInfoEntity] = []
    
    var events: [AssociatedEventEntity] = []
}
/// 医生服务界面数据模型
struct DoctorServiceEntity {
    
    var followUpPkgs: [FollowUpPackageEntity] = []
    
    var visitSchedule: [VisitScheduleEntity] = []
    
    var articles: [ArticleInfoEntity] = []
}

/// 医生详情
struct DoctorInfoEntity {
    /// 医生ID
    var doctorID: String?
    /// 医生头像URL
    var doctorAvatar: String?
    /// 医生头衔
    var doctorTitle: String?
    /// 医生姓名
    var doctorName: String?
    /// 医生标签
    var doctorTags: [Int]?
    /// 是否已关注
    var isFollow: Bool?
    /// 医院名称
    var hospitalName: String?
    /// 科室名称
    var officeName: String?
    /// 影响值
    var influenceNumber: String?
    /// 被关注人数
    var follewNumber: String?
    /// 擅长
    var goodAt: String?
    /// 从业年
    var workingYears: String?
    /// 行业成就
    var workingAchievement: String?
    /// 是否展开
    var isUnfold = true
}

/// 文章
struct ArticleInfoEntity {
    /// 是否是视频
    var isVideo: Bool?
    /// 文章标题
    var articleTitle: String?
    /// 文章作者
    var articleAuthor: String?
    /// 发布时间
    var articlePostTime: String?
    /// 视频市场
    var videoTime: String?
    /// 文章图片URL
    var articleCoverURL: String?
}

/// 关联事件
struct AssociatedEventEntity {
    
    /// 事件发生时间
    var eventTime: String?
    
    /// 事件类型 1.扫码、2.关注、3.收藏随访包、4.购买随访包、5.咨询、6.阅读干预服务包、100.完成咨询、101.发放干预服务包
    var eventType: Int? {
        didSet {
            if isDoctor == true {
                switch eventType {
                case 1:
                    eventDescribe = "扫描了我的二维码"
                case 2:
                    eventDescribe = "关注了我"
                case 4:
                    eventDescribe = "购买了在线问诊服务"
                case 5:
                    eventDescribe = "使用了一次在线问诊服务"
                case 101:
                    eventDescribe = "给ta发放了干预服务包"
                default:
                    break
                }
            }else {
                switch eventType {
                case 1:
                    eventDescribe = "扫描了医生的二维码"
                case 2:
                    eventDescribe = "关注了医生"
                case 4:
                    eventDescribe = "购买了在线问诊服务"
                case 5:
                    eventDescribe = "使用了一次在线问诊服务"
                case 101:
                    eventDescribe = "医生给我发放了健康科普文章"
                default:
                    break
                }
            }
            
        }
    }
    
    /// 是否是医生
    var isDoctor: Bool?
    
    /// 事件描述
    var eventDescribe: String?
    
    init(isDoctor: Bool) {
        self.isDoctor = isDoctor
    }
}

/// 随访包
struct FollowUpPackageEntity {
    
    /// 随访包名称
    var packageName: String?
    
    /// 咨询剩余次数
    var consultRemainTime: Int?
    
    /// 服务有效期，如90天
    var periodOfValidity: Int?
    
    /// 购买人数
    var purchaseNumber: Int?
    
    /// 收藏人数
    var collectNumber: Int?
    
    /// 价格
    var price: Double?
    
    /// 是否已收藏
    var isCollected: Bool?
    
    /// 购买次数
    var purchasesTime: Int?
    
    /// 如果已购买，是否使用过
    var hasUsed: Bool?
    
    /// 如果已购买的过期日期，格式为：2019年10月31日
    var expireDate: String?
}

/// 出诊表
struct VisitScheduleEntity {
    
    var doctorId: String?;
    
    var MonIsVisitAM: Int?;
    
    var MonIsVisitPM: Int?;
    
    var TuesIsVisitAM: Int?;
    
    var TuesIsVisitPM: Int?;
    
    var WedIsVisitAM: Int?;
    
    var WedIsVisitPM: Int?;
    
    var ThurIsVisitAM: Int?;
    
    var ThurIsVisitPM: Int?;
    
    var FriIsVisitAM: Int?;
    
    var FriIsVisitPM: Int?;
    
    var SatIsVisitAM: Int?;
    
    var SatIsVisitPM: Int?;
    
    var SunIsVisitAM: Int?;
    
    var SunIsVisitPM: Int?;
}

extension UIView{
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
