//
//  DoctorDetailSectionHeaderCell.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/10/29.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorDetailSectionHeaderCell: UITableViewCell {
    
    static var reuseId = "DoctorDetailSectionHeaderCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
    }
    
    public func configureData(_ text: String) {
        titleLabel.text = text
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(20)
        label.textColor = UIColorFromRGB(rgbValue: 0x333333)
        return label
    }()
}
