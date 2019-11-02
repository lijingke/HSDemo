//
//  AssociatedEventCell.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/10/30.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class AssociatedEventCell: UITableViewCell {
    
    static var reuseId = "AssociatedEventCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureData(_ entity: AssociatedEventEntity) {
        
        eventTime.text = entity.eventTime
        eventName.text = entity.eventDescribe
        
        if entity.eventType == 101 {
            eventType.backgroundColor = UIColorFromRGB(rgbValue: 0x549FFB)
        }else {
            eventType.backgroundColor = UIColorFromRGB(rgbValue: 0xFB6854)
        }
    }
    
    fileprivate func configureUI() {
        addSubview(eventType)
        addSubview(eventTime)
        addSubview(eventName)
        addSubview(connectingLine)
        
        eventType.snp.makeConstraints { (make) in
            make.centerY.equalTo(eventTime)
            make.left.equalToSuperview().offset(30.5)
            make.size.equalTo(6)
        }
        
        eventTime.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(eventType.snp.right).offset(5)
        }
        eventName.snp.makeConstraints { (make) in
            make.centerY.equalTo(eventTime)
            make.left.equalTo(eventTime.snp.right).offset(3)
        }
        connectingLine.snp.makeConstraints { (make) in
            make.top.equalTo(eventType.snp.bottom).offset(6)
            make.centerX.equalTo(eventType)
            make.bottom.equalToSuperview()
        }
    }
    
    lazy var eventType: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    lazy var eventTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = UIColorFromRGB(rgbValue: 0x979797)
        return label
    }()
    
    lazy var eventName: UILabel = {
        let label = UILabel()
          label.font = UIFont.regular(14)
          label.textColor = UIColorFromRGB(rgbValue: 0x444444)
          return label
    }()
    
    lazy var connectingLine: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "point_line")
        return view
    }()
}
