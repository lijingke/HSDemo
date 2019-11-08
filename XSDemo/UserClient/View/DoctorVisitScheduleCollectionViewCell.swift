//
//  DoctorVisitScheduleCollectionViewCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/5.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorVisitScheduleCollectionViewCell: UICollectionViewCell {
    static var reuseId = "DoctorVisitScheduleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(selectStatusImageView)
        addSubview(titleLabel)
        selectStatusImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.layer.borderColor = UIColorFromRGB(rgbValue: 0xE9EDF0).cgColor
        self.layer.borderWidth = 0.25
    }
    
    lazy var selectStatusImageView: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        view.image = UIImage(named: "clinic_time")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.regular(13)
        label.textColor = UIColorFromRGB(rgbValue: 0x0C1832)
        return label
    }()

}
