//
//  DoctorDetailHeaderForDoctorView.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/11/1.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorDetailHeaderForDoctorView: UIView {
    weak var delegate: DoctorDetailViewForDoctorProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColorFromRGB(rgbValue: 0x4882FF)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnAction(_ sender: UIButton) {
        delegate?.doctorInfoBtnAction(sender)
    }
    
    func showAllInfo(_ isShowAll: Bool) {
        workingYears.isHidden = !isShowAll
        workingAchievement.isHidden = !isShowAll
        if isShowAll {
            goodAt.numberOfLines = 0
            foldBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(workingAchievement.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.size.equalTo(16)
            }
        }else {
            goodAt.numberOfLines = 2
            foldBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(goodAt.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.size.equalTo(16)
            }
            
        }
        layoutIfNeeded()
    }
    
    lazy var doctorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doctor_default")
        imageView.layer.cornerRadius = 33.25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var doctorTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doctor_title")
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var titleDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(12)
        label.textColor = .white
        return label
    }()
    
    lazy var doctorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.semibold(20)
        label.textColor = .white
        return label
    }()
    
    lazy var tag1: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setTitle("门诊医生", for: .normal)
        btn.setTitleColor(UIColorFromRGB(rgbValue: 0xF36350), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isHidden = true
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    lazy var tag2: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setTitle("可咨询医生", for: .normal)
        btn.setTitleColor(UIColorFromRGB(rgbValue: 0xF36350), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.isHidden = true
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    lazy var isWatchBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1000
        btn.setImage(UIImage(named: "hook_follow"), for: .normal)
        btn.setTitle("已关注", for: .normal)
        btn.setTitleColor(UIColorFromRGB(rgbValue: 0x4882FF), for: .normal)
        btn.titleLabel?.font = UIFont.medium(16)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchDown)
        return btn
    }()
    
    lazy var hospitalName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var officeName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var influence: UILabel = {
        let label = UILabel()
        label.text = "影响力"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var influenceNumber: UILabel = {
        let label = UILabel()
        label.text = "2.67万"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var splitLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var focusedPrefix: UILabel = {
        let label = UILabel()
        label.text = "已被"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var focusedNumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.medium(18)
        return label
    }()
    
    
    lazy var focusedTail: UILabel = {
        let label = UILabel()
        label.text = "人关注"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var goodAt: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular(14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var workingYears: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular(14)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    lazy var workingAchievement: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular(14)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    lazy var foldBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn_open_doctor_infor"), for: .normal)
        btn.setImage(UIImage(named: "btn_retract_doctor_infor"), for: .selected)
        btn.tag = 1001
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchDown)
        return btn
    }()
    
}

extension DoctorDetailHeaderForDoctorView {
    
    public func configData(_ doctorInfo:
        DoctorInfoEntity) {
        
        if let avatarURL = doctorInfo.doctorAvatar {
            doctorImage.sd_setImage(with: URL(string: avatarURL), placeholderImage: UIImage(named: "doctor_default"), options: .queryDiskDataSync, completed: nil)
        }
        if let title = doctorInfo.doctorTitle {
            doctorTitle.isHidden = false
            titleDetail.text = title
        }
        doctorName.text = doctorInfo.doctorName
        
        //        tag1.isHidden = !(doctorInfo.doctorTags?.contains(1) ?? false)
        //        tag2.isHidden = !(doctorInfo.doctorTags?.contains(4) ?? false)
        
        hospitalName.text = doctorInfo.hospitalName
        officeName.text = doctorInfo.officeName
        influenceNumber.text = doctorInfo.influenceNumber
        focusedNumber.text = doctorInfo.follewNumber
        
        if doctorInfo.isFollow == true {
            isWatchBtn.setImage(UIImage(named: "hook_follow"), for: .normal)
            isWatchBtn.setTitle("已关注", for: .normal)
            isWatchBtn.setTitleColor(UIColorFromRGB(rgbValue: 0x4882FF), for: .normal)
            isWatchBtn.backgroundColor = .white
        }else {
            isWatchBtn.setImage(UIImage(named: "icon_follow"), for: .normal)
            isWatchBtn.setTitle("关注", for: .normal)
            isWatchBtn.setTitleColor(.white, for: .normal)
            isWatchBtn.backgroundColor = .clear
            isWatchBtn.layer.borderWidth = 1
            isWatchBtn.layer.borderColor = UIColor.white.cgColor
        }
        
        if let text = doctorInfo.goodAt {
            goodAt.text = "擅长：\(text)"
        }
        if let text = doctorInfo.workingYears {
            workingYears.text = "从业年：\(text)"
        }
        if let text = doctorInfo.workingAchievement {
            workingAchievement.text = "行业成就：\(text)"
        }
    }
    
    fileprivate func configureUI() {
        addSubview(doctorImage)
        addSubview(doctorTitle)
        addSubview(titleDetail)
        addSubview(doctorName)
        addSubview(tag1)
        addSubview(tag2)
        addSubview(isWatchBtn)
        addSubview(hospitalName)
        addSubview(officeName)
        addSubview(influence)
        addSubview(influenceNumber)
        addSubview(splitLine)
        addSubview(focusedPrefix)
        addSubview(focusedNumber)
        addSubview(focusedTail)
        addSubview(goodAt)
        addSubview(workingYears)
        addSubview(workingAchievement)
        addSubview(foldBtn)
        
        doctorImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17.35)
            make.left.equalToSuperview().offset(25)
            make.size.equalTo(66.5)
        }
        
        doctorTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(doctorImage)
            make.top.equalTo(doctorImage.snp.bottom).offset(-5)
        }
        
        titleDetail.snp.makeConstraints { (make) in
            make.top.equalTo(doctorTitle)
            make.centerX.equalTo(doctorTitle)
        }
        
        doctorName.snp.makeConstraints { (make) in
            make.top.equalTo(doctorImage).offset(5)
            make.left.equalTo(doctorImage.snp.right).offset(16)
        }
        
        tag1.snp.makeConstraints { (make) in
            make.top.equalTo(doctorName.snp.bottom).offset(7)
            make.left.equalTo(doctorName)
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        
        tag2.snp.makeConstraints { (make) in
            make.centerY.equalTo(tag1)
            make.left.equalTo(tag1.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 73, height: 20))
        }
        
        isWatchBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(doctorName)
            make.left.equalTo(doctorName.snp.right).offset(15)
            make.size.equalTo(CGSize(width: 86, height: 30))
        }
        
        hospitalName.snp.makeConstraints { (make) in
            make.bottom.equalTo(doctorImage)
            make.left.equalTo(doctorName)
        }
        
        officeName.snp.makeConstraints { (make) in
            make.centerY.equalTo(hospitalName)
            make.left.equalTo(hospitalName.snp.right).offset(5)
        }
        
        influence.snp.makeConstraints { (make) in
            make.top.equalTo(doctorTitle.snp.bottom).offset(20)
            make.left.equalTo(doctorTitle)
        }
        
        influenceNumber.snp.makeConstraints { (make) in
            make.centerY.equalTo(influence)
            make.left.equalTo(influence.snp.right).offset(5)
        }
        
        splitLine.snp.makeConstraints { (make) in
            make.left.equalTo(influenceNumber.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 0.5, height: 10))
            make.centerY.equalTo(influence)
        }
        
        focusedPrefix.snp.makeConstraints { (make) in
            make.left.equalTo(splitLine.snp.right).offset(20)
            make.centerY.equalTo(influence)
        }
        
        focusedNumber.snp.makeConstraints { (make) in
            make.left.equalTo(focusedPrefix.snp.right).offset(5)
            make.centerY.equalTo(focusedPrefix)
        }
        
        focusedTail.snp.makeConstraints { (make) in
            make.centerY.equalTo(focusedPrefix)
            make.left.equalTo(focusedNumber.snp.right).offset(5)
        }
        
        goodAt.snp.makeConstraints { (make) in
            make.top.equalTo(influence.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }
        
        workingYears.snp.makeConstraints { (make) in
            make.top.equalTo(goodAt.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }
        
        workingAchievement.snp.makeConstraints { (make) in
            make.top.equalTo(workingYears.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }
        
        foldBtn.snp.makeConstraints { (make) in
            make.top.equalTo(goodAt.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(16)
        }
        
        self.snp.makeConstraints { (make) in
            make.top.equalTo(doctorImage.snp.top).offset(-17.5)
            make.bottom.equalTo(foldBtn.snp.bottom).offset(16)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
    }
}
