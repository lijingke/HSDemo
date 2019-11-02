//
//  DoctorPostArticleCell.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/10/29.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorPostArticleCell: UITableViewCell {
    
    static var reuseId = "DoctorPostArticleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    public func configureData(_ data: ArticleInfoEntity) {
        
        if data.isVideo == true {
            playTime.isHidden = false
            playIcon.isHidden = false
            playTime.setTitle(data.videoTime, for: .normal)
        }
        if let imageURL = data.articleCoverURL {
            self.articleCover.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "pages_img_def"), options: .queryDiskDataSync, completed: nil)
            
        }
        self.articleTitle.text = data.articleTitle
        self.articleAuthor.text = data.articleAuthor
        self.articlePostTime.text = data.articlePostTime
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(articleTitle)
        addSubview(articleCover)
        addSubview(articleAuthor)
        addSubview(articlePostTime)
        addSubview(splitLine)
        
        articleCover.addSubview(playIcon)
        articleCover.addSubview(playTime)
        
        articleTitle.snp.makeConstraints { (make) in
            make.top.equalTo(articleCover)
            make.left.equalToSuperview().offset(20)
            make.right.lessThanOrEqualTo(articleCover.snp.left).offset(-50)
        }
        
        articleCover.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 108, height: 81))
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        articleAuthor.snp.makeConstraints { (make) in
            make.left.equalTo(articleTitle)
            make.bottom.equalTo(articleCover)
        }
        
        articlePostTime.snp.makeConstraints { (make) in
            make.bottom.equalTo(articleCover)
            make.right.equalTo(articleCover.snp.left).offset(-50)
        }
        
        playIcon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(33)
        }
        
        playTime.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.bottom.right.equalToSuperview()
        }
        
        splitLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = UIColorFromRGB(rgbValue: 0x333333)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var articleCover: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pages_img_def")
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var articleAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(12)
        label.textColor = UIColorFromRGB(rgbValue: 0xC9CBCE)
        return label
    }()
    
    lazy var articlePostTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(12)
        label.textColor = UIColorFromRGB(rgbValue: 0xC9CBCE)
        return label
    }()
    
    lazy var playIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "vedio_play")
        view.isHidden = true
        return view
    }()
    
    lazy var playTime: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.regular(10)
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btn.isHidden = true
        return btn
    }()
    
    lazy var splitLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorFromRGB(rgbValue: 0xEBEBED)
        return view
    }()
    
}
