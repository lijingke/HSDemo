//
//  DoctorRecommendedCell.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/10/30.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorRecommendedCell: UITableViewCell {
    
    static let reuseId = "DoctorRecommendedCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureData(_ entity: ArticleInfoEntity) {
        articleTitle.text = entity.articleTitle
        articleAuthor.text = entity.articleAuthor
    }
    
    fileprivate func configureUI() {
        addSubview(articleTitle)
        addSubview(articleAuthor)
        
        articleTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(30.5)
            make.right.lessThanOrEqualToSuperview().offset(-56.5)
        }
        articleAuthor.snp.makeConstraints { (make) in
            make.top.equalTo(articleTitle.snp.bottom).offset(1)
            make.left.equalTo(articleTitle)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = UIColorFromRGB(rgbValue: 0x182131)
        return label
    }()
    
    lazy var articleAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(13)
        label.textColor = UIColorFromRGB(rgbValue: 0xA4ABB6)
        return label
    }()
}
