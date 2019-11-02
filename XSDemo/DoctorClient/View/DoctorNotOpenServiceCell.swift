//
//  DoctorNotOpenServiceCell.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/11/1.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorNotOpenServiceCell: UITableViewCell {
    
    static var reuseId = "DoctorNotOpenServiceCell"
    weak var delegate: DoctorDetailViewForDoctorProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(hintLabel)
        addSubview(settingBtn)
        
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(82)
            make.right.equalToSuperview().offset(-82)
        }
        
        settingBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(hintLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 120, height: 36))
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    @objc func settingBtnAction(_ sender: UIButton) {
        delegate?.doctorDidClickOpenService(sender.tag)
    }
    
    /// 配置页面数据
    /// - Parameter hintText: 提示语
    /// - Parameter btnTitle: Button标题，不传值时按钮隐藏，一旦设置必须同时设置相应的btnType
    /// - Parameter btnType: Button类型，1000为开通在线问诊，1001为开通出诊表
    public func configureData(hintText: String , btnTitle: String = "", btnType: Int = 0) {
        hintLabel.text = hintText
        
        settingBtn.isHidden = btnTitle.count == 0
        
        if btnTitle.count > 0 {
            settingBtn.tag = btnType
            settingBtn.setTitle(btnTitle, for: .normal)
        }else {
            hintLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(20)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(82)
                make.right.equalToSuperview().offset(-82)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
    }
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = UIColorFromRGB(rgbValue: 0xAAAAAA)
        label.textAlignment =  NSTextAlignment.center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var settingBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "doctor_page_btn_setting_bg"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.addTarget(self, action: #selector(settingBtnAction(_:)), for: .touchDown)
        return btn
    }()
}
