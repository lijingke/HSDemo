//
//  DoctorVisitScheduleTableViewCell.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/5.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorVisitScheduleTableViewCell: UITableViewCell {
    
    static var reuseId = "OutpatientServiceTableViewCell"
    
    var week = ["","周一","周二","周三","周四","周五","周六","周日"]
    var addVisitSchedule : [visitScheduleEntityOld] = []
    public var canEditor : Bool = false
    public var visitSchedule : [visitScheduleEntityOld] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(0)
        }
        
        for index in 0...7 {
            let entity = visitScheduleEntityOld(day: index, is_visit_am: 1, is_visit_pm: 0)
            self.addVisitSchedule.append(entity)
        }
        
        setNeedsLayout()
        layoutIfNeeded()

        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(height / 2)
        }
        collectionView.reloadData()
    }
    
    public func setUpVisitSchedule(visitSchedule : [visitScheduleEntityOld]){
        self.visitSchedule.removeAll()
        self.visitSchedule = [visitScheduleEntityOld(day: 0, is_visit_am: 0, is_visit_pm: 0)]
        self.visitSchedule.append(contentsOf: visitSchedule)
        if self.canEditor == true {
            for (index,entity) in self.visitSchedule.enumerated(){
                self.addVisitSchedule[index] = entity
            }
        }
        self.collectionView.reloadData()
    }
    
    public func fetchVisitSchedules() -> [visitScheduleEntityOld]{
        //检测没有数据的部分
        return self.addVisitSchedule.filter({ return $0.day != 0})
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .groupTableViewBackground
        view.delegate = self
        view.dataSource = self
        view.register(DoctorVisitScheduleCollectionViewCell.self, forCellWithReuseIdentifier: DoctorVisitScheduleCollectionViewCell.reuseId)
        return view
    }()
    
}

extension DoctorVisitScheduleTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:UIScreen.main.bounds.size.width/8, height: UIScreen.main.bounds.size.width / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //勾选数据部分
        if self.canEditor == true{
            if indexPath.section == 1 || indexPath.section == 2{
                if (1...7).contains(indexPath.item) {
                    if var entity : visitScheduleEntityOld = self.addVisitSchedule[indexPath.item]{
                        if indexPath.section == 1{
                            entity.is_visit_am = (entity.is_visit_am == 0) ? 1 : 0
                        }else if indexPath.section == 2{
                            entity.is_visit_pm = (entity.is_visit_pm == 0) ? 1 : 0
                        }
                        self.addVisitSchedule[indexPath.item] = entity
                    }
                }
            }
            self.collectionView.reloadData()
        }
    }
}

extension DoctorVisitScheduleTableViewCell: UICollectionViewDelegate {
    
}

extension DoctorVisitScheduleTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorVisitScheduleCollectionViewCell.reuseId, for: indexPath) as? DoctorVisitScheduleCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.section == 0 {
            cell.backgroundColor = UIColorFromRGB(rgbValue: 0xF5F7FA)
            cell.titleLabel.isHidden = false
            cell.titleLabel.text = self.week[indexPath.item]
        }else {
            if indexPath.item == 0 {
                cell.backgroundColor = UIColorFromRGB(rgbValue: 0xF5F7FA)
                cell.titleLabel.isHidden = false
                if indexPath.section == 1 {
                    cell.titleLabel.text = "上午"
                }else if indexPath.section == 2 {
                    cell.titleLabel.text = "下午"
                }
            }else {
                cell.backgroundColor = UIColor.white
                
                if (1...7).contains(indexPath.item){
                    cell.titleLabel.isHidden = true
                    if let count : Int = (self.canEditor == false) ? self.visitSchedule.count : self.addVisitSchedule.count , count > indexPath.item{
                        let entity : visitScheduleEntityOld = self.canEditor == false ? self.visitSchedule[indexPath.item] : self.addVisitSchedule[indexPath.item]
                        if indexPath.section == 1{
                            print((entity.is_visit_am == 1) ? false : true)
                            cell.selectStatusImageView.isHidden = (entity.is_visit_am == 1) ? false : true
                        }else{
                            print((entity.is_visit_am == 1) ? false : true)
                            cell.selectStatusImageView.isHidden = (entity.is_visit_pm == 1) ? false : true
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
}
