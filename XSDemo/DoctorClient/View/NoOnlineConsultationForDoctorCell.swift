//
//  NoOnlineConsultationForDoctorCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class NoOnlineConsultationForDoctorCell: UITableViewCell {
    
    static var reuseId = "NoOnlineConsultationCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(placeHolderImg)
        addSubview(placeHolderText)
        
        placeHolderImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            //            make.size.equalTo(CGSize(width: 182, height: 165.5))
        }
        placeHolderText.snp.makeConstraints { (make) in
            make.centerX.equalTo(placeHolderImg)
            make.top.equalTo(placeHolderImg.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    lazy var placeHolderImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty_nodata")
        return view
    }()
    
    lazy var placeHolderText: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = UIColorFromRGB(rgbValue: 0xAAAAAA)
        label.text = "医生暂未开通在线问诊服务"
        return label
    }()
    
}
