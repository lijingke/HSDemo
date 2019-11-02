//
//  DoctorDetailForDoctorView.swift
//  NGOFundManager
//
//  Created by 李京珂 on 2019/11/1.
//  Copyright © 2019 GRDOC. All rights reserved.
//

import UIKit

class DoctorDetailForDoctorView: UIView {
    
    weak var delegate: DoctorDetailViewForDoctorProtocol?
    
    /// 医生详情
    public var doctorInfo = DoctorInfoEntity()
    
    /// 每个Section的标题
    private var sectionTitle = ["在线问诊", "出诊表", "医生发布的文章"]
    
    /// 每个Section尾部的加载更多状态
    public var expandArray = [false, false, false]
    
    /// 是否为医生自己
    public var isDoctorSelf: Bool = false
    
    /// 医生服务的数据源
    public var dataSource = DoctorServiceEntity()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        creatData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.tableHeaderView.frame
        frame.size.height = height
        tableHeaderView.frame = frame
        tableHeaderView.configData(getDoctorInfoData())
        tableHeaderView.setNeedsLayout()
        tableView.tableHeaderView = self.tableHeaderView
        
        self.layoutIfNeeded()
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.estimatedSectionHeaderHeight = 10
        table.estimatedSectionFooterHeight = 10
        table.register(DoctorDetailSectionHeaderForDoctorCell.self, forCellReuseIdentifier: DoctorDetailSectionHeaderForDoctorCell.reuseId)
        table.register(DoctorNotOpenServiceCell.self, forCellReuseIdentifier: DoctorNotOpenServiceCell.reuseId)
        table.register(FollowUpPackageForDoctorCell.self, forCellReuseIdentifier: FollowUpPackageForDoctorCell.reuseId)
        table.register(DoctorPostArticleForDoctorCell.self, forCellReuseIdentifier: DoctorPostArticleForDoctorCell.reuseId)
        table.register(NoOnlineConsultationForDoctorCell.self, forCellReuseIdentifier: NoOnlineConsultationForDoctorCell.reuseId)
        
        table.separatorStyle = .none
        return table
    }()
    
    lazy var tableHeaderView: DoctorDetailHeaderForDoctorView = {
        let view = DoctorDetailHeaderForDoctorView()
        view.delegate = self
        return view
    }()
    
}
// MARK: - TableView代理
extension DoctorDetailForDoctorView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = DoctorDetailSectionHeaderView()
            header.backgroundColor = UIColorFromRGB(rgbValue: 0x4882FF)
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 10
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = LoadMoreFootForDoctorView()
        foot.delegate = self
        foot.atSection = section
        foot.loadMoreBtn.isSelected = expandArray[section]
        return foot
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return dataSource.followUpPkgs.count > 3 ? 40 : 0
        case 1:
            return dataSource.visitSchedule.count > 3 ? 40 : 0
        case 2:
            return dataSource.articles.count > 3 ? 40 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row != 0 {
            let entity = dataSource.articles[indexPath.row - 1]
            print(entity)
        }
    }
    
}

// MARK: - TableView的数据源代理
extension DoctorDetailForDoctorView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let num = dataSource.followUpPkgs.count
            if num > 3 && expandArray[section] == false {
                return 4
            }else {
                return num > 0 ? num + 1 : 2
            }
        case 1:
            let num = dataSource.visitSchedule.count
            if num > 3 && expandArray[section] == false {
                return 4
            }else {
                if isDoctorSelf {
                    return num > 0 ? num + 1 : 2
                }else {
                    return num > 0 ? num + 1 : 0
                }
            }
        case 2:
            let num = dataSource.articles.count
            if num > 3 && expandArray[section] == false {
                return 4
            }else {
                if isDoctorSelf {
                    return num > 0 ? num + 1 : 2
                }else {
                    return num > 0 ? num + 1 : 0
                }
            }
            
        default:
            break
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorDetailSectionHeaderForDoctorCell.reuseId, for: indexPath) as? DoctorDetailSectionHeaderForDoctorCell else { return UITableViewCell() }
            cell.configureData(sectionTitle[indexPath.section])
            
            return cell
        }else {
            switch indexPath.section {
            case 0:
                if dataSource.followUpPkgs.count > 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowUpPackageForDoctorCell.reuseId, for: indexPath) as? FollowUpPackageForDoctorCell else {
                        return UITableViewCell()
                    }
                    
                    let entity = dataSource.followUpPkgs[indexPath.row - 1]
                    cell.configureData(entity)
                    return cell
                }else {
                    if isDoctorSelf {
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorNotOpenServiceCell.reuseId, for: indexPath) as? DoctorNotOpenServiceCell else {
                            return UITableViewCell()
                        }
                        cell.configureData(hintText: "有70%的医生已经开通了在线问诊服务，现在就去开通吧~", btnTitle: "立即开通", btnType: 1000)
                        cell.delegate = self
                        return cell
                    }else {
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoOnlineConsultationForDoctorCell.reuseId, for: indexPath) as? NoOnlineConsultationForDoctorCell else { return UITableViewCell() }
                        return cell
                    }
                }
            case 1:
                if dataSource.visitSchedule.count > 0 {
                    return UITableViewCell()
                }else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorNotOpenServiceCell.reuseId, for: indexPath) as? DoctorNotOpenServiceCell else {
                        return UITableViewCell()
                    }
                    cell.configureData(hintText: "设置出诊时间，让患者在合适的时间与您沟通哦~", btnTitle: "立即设置", btnType: 1001)
                    cell.delegate = self
                    return cell
                }
            case 2:
                if dataSource.articles.count > 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorPostArticleForDoctorCell.reuseId, for: indexPath) as? DoctorPostArticleForDoctorCell else {
                        return UITableViewCell()
                    }
                    let entity = dataSource.articles[indexPath.row - 1]
                    cell.configureData(entity)
                    return cell
                }else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorNotOpenServiceCell.reuseId, for: indexPath) as? DoctorNotOpenServiceCell else {
                        return UITableViewCell()
                    }
                    cell.configureData(hintText: "发布文章可以提高影响力哦，快联系疾控中心开始发布吧~")
                    cell.delegate = self
                    return cell
                }
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
}

// MARK: - View点击事件的代理
extension DoctorDetailForDoctorView: DoctorDetailViewForDoctorProtocol {
    
    func clickLoadMore(_ sender: UIButton, atSection: Int) {
        sender.isSelected.toggle()
        expandArray[atSection] = sender.isSelected
        tableView.reloadData()
    }
    
    func doctorInfoBtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            doctorInfo.isFollow?.toggle()
            tableHeaderView.configData(doctorInfo)
            break
        case 1001:
            sender.isSelected.toggle()
            tableHeaderView.showAllInfo(sender.isSelected)
            tableView.reloadData()
        default:
            break
        }
    }
    
    func doctorDidClickOpenService(_ btnType: Int) {
        delegate?.doctorDidClickOpenService(btnType)
    }
}

// MARK: - ScrollView的代理
extension DoctorDetailForDoctorView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 禁止Tableview偏移量小于0时下拉
        var offset = tableView.contentOffset
        if offset.y <= 0 {
            offset.y = 0
        }
        tableView.contentOffset = offset
        
        let offsetY = scrollView.contentOffset.y
        let vc = self.getFirstViewController()
        
        let titleOringY = tableHeaderView.doctorName.frame.origin.y +  tableHeaderView.doctorName.frame.size.height
        
        if offsetY > titleOringY {
            vc?.navigationItem.title = doctorInfo.doctorName
        }else {
            vc?.navigationItem.title = ""
        }
    }
}

// MARK: - 数据源赋值方法
extension DoctorDetailForDoctorView {
    
    fileprivate func getArticleInfo() -> ArticleInfoEntity {
        var info = ArticleInfoEntity()
        info.isVideo = true
        info.articleTitle = "文章标题三行文字时文章标题三行文字时文章标题三行文字时"
        info.articleAuthor = "国家疾控中心"
        info.articlePostTime = "30分钟前"
        info.videoTime = "01:45"
        info.articleCoverURL = "https://c-ssl.duitang.com/uploads/item/201409/12/20140912224624_CTaMm.thumb.1700_0.png"
        return info
    }
    
    fileprivate func getDoctorInfoData() -> DoctorInfoEntity {
        doctorInfo.doctorName = "武合璇"
        doctorInfo.doctorAvatar = "https://c-ssl.duitang.com/uploads/item/201409/12/20140912224624_CTaMm.thumb.1700_0.png"
        doctorInfo.doctorTitle = "主任医师"
        doctorInfo.doctorTags = [1,2,3,4,5]
        doctorInfo.isFollow = true
        doctorInfo.hospitalName = "南京皮防所"
        doctorInfo.officeName = "皮肤科"
        doctorInfo.influenceNumber = "2.67万"
        doctorInfo.follewNumber = "1409"
        doctorInfo.goodAt = "治疗恐艾心理疏导，艾滋病、慢性治疗恐艾心理病,治疗恐艾心理治疗恐艾心理疏导，艾滋病、慢性治疗恐艾心理病,治疗恐艾心理治疗恐艾心理疏导，艾滋病、慢性治疗恐艾心理病,治疗恐艾心理治疗恐艾心理疏导，艾滋病、慢性治疗恐艾心理病,治疗恐艾心理"
        doctorInfo.workingYears = "2001年"
        doctorInfo.workingAchievement = "这是行业成就的详情信息展示所有的超过一行直接换行。"
        return doctorInfo
    }
    
    /// 假数据制造，等待删除
    fileprivate func creatData() {
        
        isDoctorSelf = true
        
        for _ in 0...3 {
            var entity = FollowUpPackageEntity()
            entity.packageName = "随访包名称"
            entity.consultRemainTime = 200
            entity.periodOfValidity = 90
            entity.purchaseNumber = 235
            entity.collectNumber = 90
            entity.price = 90.00
            entity.isCollected = true
            entity.purchasesTime = 3
            dataSource.followUpPkgs.append(entity)
        }
        for _ in 0...3 {
            let entity = VisitScheduleEntity()
            dataSource.visitSchedule.append(entity)
        }
        for _ in 0...3 {
            let entity = getArticleInfo()
            dataSource.articles.append(entity)
        }
        
        let shouldChangeBackgroudColor = dataSource.followUpPkgs.count == 0 && dataSource.visitSchedule.count == 0 && dataSource.articles.count == 0
        
        if isDoctorSelf == false && shouldChangeBackgroudColor {
            tableView.backgroundColor = .white
        }
        
        if isDoctorSelf {
            tableHeaderView.isWatchBtn.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    /// 医生端医生详情页面赋值方法
    /// - Parameters:
    ///   - doctorInfo: 医生信息
    ///   - dataSource: 医生服务数据
    ///   - isDoctorSelf: 是否是医生本人，false为医生查看其它医生页面
    public func configureData(doctorInfo: DoctorInfoEntity, dataSource: DoctorServiceEntity, isDoctorSelf: Bool) {
        self.doctorInfo = doctorInfo
        self.dataSource = dataSource
        
        self.isDoctorSelf = isDoctorSelf
        
        let shouldChangeBackgroudColor = dataSource.followUpPkgs.count == 0 && dataSource.visitSchedule.count == 0 && dataSource.articles.count == 0
        
        if isDoctorSelf == false && shouldChangeBackgroudColor {
            tableView.backgroundColor = .white
        }
        
        if isDoctorSelf {
            tableHeaderView.isWatchBtn.isHidden = true
        }
        
        tableView.reloadData()
    }
}
