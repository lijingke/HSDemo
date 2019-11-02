//
//  FollowUpPackageForDoctorCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class FollowUpPackageForDoctorCell: UITableViewCell {
    
    static var reuseId = "FollowUpPackageForDoctorCell"
    var entity: FollowUpPackageEntity?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureData(_ entity: FollowUpPackageEntity) {
        
        self.entity = entity
        
        if let name = entity.packageName {
            packageName.text = name
        }
        
        if let num = entity.purchasesTime {
            purchaseStatus.setTitle("您购买过\(num)次", for: .normal)
        }
        
        if let time = entity.consultRemainTime {
            let aStr = "图文咨询\(time)次".modifyNumberColor(color: UIColorFromRGB(rgbValue: 0xFF4919), font: UIFont.regular(14)!)
            usageCount.attributedText = aStr
        }
        
        if let time = entity.periodOfValidity {
            let aStr = "服务有效期\(time)天".modifyNumberColor(color: UIColorFromRGB(rgbValue: 0xFF4919), font: UIFont.regular(14)!)
            expirationTime.attributedText = aStr
        }
        
        if let price = entity.price {
            if price > 0 {
                bookPrice.setTitle("¥\(price)", for: .normal)
            }else {
                bookPrice.setTitle("免费", for: .normal)
            }
        }
        
        if let purNum = entity.purchaseNumber, let collectNum = entity.collectNumber {
            packageDetail.text = "\(purNum)人已购买 · \(collectNum)人收藏"
        }
    }
    
    lazy var bgImageView:UIImageView = {
        let bg = UIImageView();
        let image = UIImage.init(named: "bg_shadow")?.resizableImage(withCapInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), resizingMode: UIImage.ResizingMode.stretch)
        bg.image = image;
        return bg;
    }()
    
    lazy var icon1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorFromRGB(rgbValue: 0xFF4919)
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var icon2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorFromRGB(rgbValue: 0xFF4919)
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var packageName: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(17)
        label.text = "随访包名称"
        return label
    }()
    
    lazy var purchaseStatus: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isHidden = true
        btn.backgroundColor = UIColorFromRGB(rgbValue: 0xEDF3FB)
        btn.titleLabel?.font = UIFont.regular(12)
        btn.setTitleColor(UIColorFromRGB(rgbValue: 0x4D8BD9), for: .normal)
        btn.layer.cornerRadius = 2
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return btn
    }()
    
    lazy var usageCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        return label
    }()
    
    lazy var expirationTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        return label
    }()
    
    lazy var splitLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorFromRGB(rgbValue: 0xE3E3E3)
        return view
    }()
    
    lazy var packageDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(13)
        label.textColor = UIColorFromRGB(rgbValue: 0xB4B2B2)
        return label
    }()
    
    lazy var bookPrice: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1000
        btn.setTitleColor(UIColorFromRGB(rgbValue: 0xFF4919), for: .normal)
        btn.titleLabel?.font = UIFont.semibold(16)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
}

extension FollowUpPackageForDoctorCell {
    fileprivate func configureUI() {
        addSubview(bgImageView)
        addSubview(packageName)
        addSubview(purchaseStatus)
        addSubview(icon1)
        addSubview(usageCount)
        addSubview(icon2)
        addSubview(expirationTime)
        addSubview(splitLine)
        addSubview(packageDetail)
        addSubview(bookPrice)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(140)
        }
        
        packageName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(25)
        }
        
        purchaseStatus.snp.makeConstraints { (make) in
            make.centerY.equalTo(packageName)
            make.left.equalTo(packageName.snp.right).offset(13.5)
        }
        
        icon1.snp.makeConstraints { (make) in
            make.top.equalTo(packageName.snp.bottom).offset(14.5)
            make.left.equalTo(packageName)
            make.size.equalTo(5)
        }
        
        usageCount.snp.makeConstraints { (make) in
            make.left.equalTo(icon1.snp.right).offset(4)
            make.centerY.equalTo(icon1)
        }
        
        icon2.snp.makeConstraints { (make) in
            make.left.size.equalTo(icon1)
            make.top.equalTo(icon1.snp.bottom).offset(19)
        }
        
        expirationTime.snp.makeConstraints { (make) in
            make.left.equalTo(icon2.snp.right).offset(4)
            make.centerY.equalTo(icon2)
        }
        
        splitLine.snp.makeConstraints { (make) in
            make.top.equalTo(expirationTime.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        packageDetail.snp.makeConstraints { (make) in
            make.top.equalTo(splitLine.snp.bottom).offset(7)
            make.left.equalTo(icon2)
        }
        
        bookPrice.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 94, height: 30))
            make.centerY.equalTo(usageCount.snp.bottom)
            make.right.equalToSuperview().offset(-25)
        }
    }
}
