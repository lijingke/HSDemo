//
//  PurchasedFollowUpPackageCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/10/30.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit
 
class PurchasedFollowUpPackageCell: UITableViewCell {
    
    static var reuseId = "PurchasedFollowUpPackageCell"
    weak var delegate: DoctorDetailViewProtocol?
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
        
        if let name = entity.packageName, let hasUsed = entity.hasUsed {
            
            let attrStr = NSAttributedString(string: "\(name)  ", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: 0x333333)])
            
            let attachment = NSTextAttachment()
            if hasUsed {
                attachment.image = UIImage(named: "label_ongoing")
            }else {
                attachment.image = UIImage(named: "label_not_used")
            }
            let font = packageName.font

            attachment.bounds = CGRect(x: 0, y: (font!.capHeight - (attachment.image?.size.height)!) / 2 - 1, width: (attachment.image?.size.width)!, height: (attachment.image?.size.height)!)
            let attrImage = NSAttributedString(attachment: attachment)
            
            let attrMub = NSMutableAttributedString()
            attrMub.append(attrStr)
            attrMub.append(attrImage)
            
            packageName.attributedText = attrMub
        }
        
        if entity.hasUsed == true {
            consultingBtn.status = 0
        }else {
            consultingBtn.status = 1
        }
        
        if let expirationDate = entity.expireDate, let remainTime = entity.consultRemainTime {
            let str = "在\(expirationDate)之前您还可以咨询\(remainTime)次"
            let aStr = str.modifyNumberColor(color: UIColorFromRGB(rgbValue: 0xFF9115), font: UIFont.medium(14)!, regx: "([\\d+|年|月|日|次])")
            expiredTime.attributedText = aStr
        }
    }
    
    fileprivate func configureUI() {
        
        addSubview(bgImageView)
        bgImageView.addSubview(packageName)
        bgImageView.addSubview(expiredTime)
        bgImageView.addSubview(consultingBtn)
        
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
            
        }
        
        packageName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-40)
        }

        expiredTime.snp.makeConstraints { (make) in
            make.top.equalTo(packageName.snp.bottom).offset(5)
            make.left.equalTo(packageName)
        }

        consultingBtn.snp.makeConstraints { (make) in
            make.top.equalTo(expiredTime.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(25)
            make.right.equalTo(packageName)
            make.bottom.equalTo(bgImageView.snp.bottom).offset(-20)
            make.height.equalTo(40)
        }
        
    }
    
    lazy var bgImageView:UIImageView = {
      let bg = UIImageView();
      let image = UIImage.init(named: "bg_shadow")?.resizableImage(withCapInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), resizingMode: UIImage.ResizingMode.stretch)
      bg.image = image;
      return bg;
    }()
    
    lazy var packageName: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(17)
        label.text = "随访包名称"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var expiredTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = UIColorFromRGB(rgbValue: 0xBCBBB9)
        return label
    }()
    
    lazy var consultingBtn: ConsultingButton = {
        let view = ConsultingButton()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.btnAction = { [weak self]() in
            self?.delegate?.didClickConsultBtn(self?.entity ?? FollowUpPackageEntity())
        }
        return view
    }()
    
}

class ConsultingButton: UIView {
    
    public var btnAction:(()->())?
    
    public var status: Int = 0 {
        didSet {
            if self.status == 0 {
                title.text = "继续咨询"
            }else if self.status == 1 {
                title.text = "立即咨询"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAction() {
        btnAction?()
    }
    
    fileprivate func configureUI() {
        self.backgroundColor = UIColorFromRGB(rgbValue: 0xE4EEFA)
        addSubview(title)
        addSubview(arrowIcon)
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        arrowIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 21, height: 13))
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        
        self.addGestureRecognizer(gesture)
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColorFromRGB(rgbValue: 0x238AFF)
        label.font = UIFont.medium(16)
        return label
    }()
    
    lazy var arrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "enter_consultat")
        return view
    }()
}
