//
//  DoctorVisitScheduleHeaderCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/5.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorVisitScheduleHeaderCell: UITableViewCell {
    
    static let reuseId = "DoctorVisitScheduleHeaderCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(unvisitBgView);
        unvisitBgView.addSubview(unvisitLabel);
        unvisitBgView.addSubview(unvisitImageView);

        unvisitBgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(28)
        }
        
        unvisitLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview();
            make.height.equalTo(28);
            make.width.equalTo(1);
        }
        
        unvisitImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(unvisitLabel.snp.leading);
            make.centerY.equalToSuperview();
            make.width.equalTo(11.55);
            make.height.equalTo(11.55);
        }
    }
    
    public func loadData(data: UnvisitTimeEntity) {
        if let startTime = data.startTime, let endTime = data.endTime {
            let startStr = Date(timeIntervalSince1970: Double(startTime / 1000)).stringWithFormat(format: "yyyy年M月dd日");
            let startHourStr = Date(timeIntervalSince1970: Double(startTime / 1000)).stringWithFormat(format: "HH");
            var startAmOrPmStr = "";
            if (Int(startHourStr) ?? 0) < 12 {
                startAmOrPmStr = "上午";
            }else {
                startAmOrPmStr = "下午";
            }
            let endStr = Date(timeIntervalSince1970: Double(endTime / 1000)).stringWithFormat(format: "yyyy年M月dd日");
            let endHourStr = Date(timeIntervalSince1970: Double(endTime / 1000)).stringWithFormat(format: "HH");
            var endAmOrPmStr = "";
            if (Int(endHourStr) ?? 0) < 12 {
                endAmOrPmStr = "上午";
            }else {
                endAmOrPmStr = "下午";
            }
            let contentStr = "医生" + startStr + startAmOrPmStr + "至" + endStr + endAmOrPmStr + "停诊";
//            let contentSize = NSString(string: contentStr).size(with: unvisitLabel.font, maxSize: CGSize(width: CGFloat(MAXFLOAT), height: 16.5));
            let contentSize: CGSize = CGSize(width: 100, height: 16.5)
            unvisitLabel.snp.updateConstraints { (make) in
                make.width.equalTo(contentSize.width + 1);
            }
        }else {
            unvisitBgView.removeFromSuperview()
            self.snp.makeConstraints { (make) in
                make.height.equalTo(0.3)
            }
        }
        setNeedsLayout()
        layoutIfNeeded()
    }

    fileprivate lazy var unvisitBgView: UIView = {
        let view = UIView();
        view.backgroundColor = UIColor.rgb(hex: 0xEC3F2A);
        view.alpha = 0.83;
        return view;
    }()
    
    fileprivate lazy var unvisitImageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "remind_close");
        return imageView;
    }()
    
    fileprivate lazy var unvisitLabel: UILabel = {
        let lab = UILabel();
        lab.font = UIFont(name: "PingFangSC-Regular", size: 12);
        lab.textColor = UIColor.rgb(hex: 0xEA6251);
        return lab;
    }()
    
}
