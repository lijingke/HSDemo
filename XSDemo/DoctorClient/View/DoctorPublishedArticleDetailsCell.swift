//
//  DoctorPublishedArticleDetailsCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/7.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

protocol MyPatientClickEventProtocol: NSObject {
    func doctorPublishedEvent()
}

class DoctorPublishedArticleDetailsCell: UITableViewCell {
    
    static var reuseId = "DoctorPublishedArticleDetailsCell"
    
    weak var delegate: MyPatientClickEventProtocol?
    
    var foldAction:(()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureData(_ article: ArticleInfoEntity) {
        
        titleLabel.text = "已累积发放3篇文章"
        contentLabel.text = "就显复成超3行"
        
        let lines = contentLabel.lines
        
        if lines < 4 {
            foldBtn.isHidden = true
            foldBtn.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(contentLabel.snp.bottom).offset(5)
                make.size.equalTo(CGSize.zero)
            }
        }else {
            foldBtn.isHidden = false
            foldBtn.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(contentLabel.snp.bottom).offset(5)
            }
            
        }
        
        if lines > 3 && foldBtn.isSelected == false {
            contentLabel.numberOfLines = 3
        }else {
            contentLabel.numberOfLines = 0
        }
        
    }
    
    @objc func btnAction(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            foldAction?()
        case 1001:
            delegate?.doctorPublishedEvent()
        default:
            break
        }
    }
    
    fileprivate func configureUI() {
        addSubview(backView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(publishedBtn)
        addSubview(foldBtn)
        addSubview(publishedBtn)
        
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backView).offset(11)
            make.left.equalTo(backView).offset(10)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        foldBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
        }
        
        publishedBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(foldBtn.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15.5)
            make.size.equalTo(CGSize(width: 90, height: 29.35))
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(18)
        label.textColor = UIColorFromRGB(rgbValue: 0x333333)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = UIColorFromRGB(rgbValue: 0x585F6E)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var foldBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1000
        btn.setImage(UIImage(named: "btn_open_pages"), for: .normal)
        btn.setImage(UIImage(named: "btn_retract_pages"), for: .selected)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchDown)
        return btn
    }()
    
    lazy var publishedBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1001
        btn.setBackgroundImage(UIImage(named: "patient_page_btn_grant_bg"), for: .normal)
        btn.setTitle("再次发放", for: .normal)
        btn.titleLabel?.font = UIFont.regular(14)
        btn.titleLabel?.textColor = .white
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchDown)
        return btn
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
}
