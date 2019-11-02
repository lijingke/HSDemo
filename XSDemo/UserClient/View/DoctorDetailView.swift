//
//  DoctorDetailView.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/10/28.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit
import MJRefresh

class DoctorDetailView: UIView {
    
    weak var delegate: DoctorDetailViewProtocol?
    
    /// 医生详情
    public var doctorInfo = DoctorInfoEntity()
    
    /// 医生与我的数据源
    public var doctorAndMeDataSource = DoctorWithMeEntity() {
        didSet {
            if doctorAndMeDataSource.followUpPkgs.count == 0 && doctorAndMeDataSource.articles.count == 0 && doctorAndMeDataSource.events.count == 0 {
                shouldHideHeader = true
            }else {
                shouldHideHeader = false
            }
        }
    }
    /// 医生服务的数据源
    public var doctorServiceDataSource = DoctorServiceEntity()
    
    /// 当医生与我无数据时隐藏切换按钮界面
    public var shouldHideHeader: Bool = false
    
    /// 每个Section的标题
    public var sectionTitle = [["可使用的在线问诊服务", "医生推荐我阅读的文章", "医生与我的关联"], ["在线问诊", "出诊表", "医生发布的文章"]]
    
    /// 每个Section尾部的加载更多状态
    public var expandArray = [[false, false, false], [false, false, false]]
    
    /// 标记当前使用的数据源，0为医生与我，1为医生服务
    private var segmentTag = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("释放")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.segmentBar.backgroundColor = UIColorFromRGB(rgbValue: 0xFF7056)
        self.segmentBar.backgroundView.backgroundColor = .white
        self.segmentBar.backgroundView.addCorner(conrners: [.topLeft, .topRight], radius: 10)
    }
    
    fileprivate func configureUI() {
        addSubview(tableView)
        addSubview(floatingSegmentBar)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        floatingSegmentBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.tableHeaderView.frame
        frame.size.height = height
        tableHeaderView.frame = frame
        tableHeaderView.configData(getDoctorInfoData())
        tableHeaderView.setNeedsLayout()
        tableView.tableHeaderView = self.tableHeaderView
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self]() in
            self?.tableView.mj_footer.endRefreshing()
            self?.tableView.mj_footer.endRefreshingWithNoMoreData()
        })
        
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
        table.register(DoctorDetailSectionHeaderCell.self, forCellReuseIdentifier: DoctorDetailSectionHeaderCell.reuseId)
        table.register(FollowUpPackageTableViewCell.self, forCellReuseIdentifier: FollowUpPackageTableViewCell.reuseId)
        table.register(DoctorPostArticleCell.self, forCellReuseIdentifier: DoctorPostArticleCell.reuseId)
        table.register(PurchasedFollowUpPackageCell.self, forCellReuseIdentifier: PurchasedFollowUpPackageCell.reuseId)
        table.register(DoctorRecommendedCell.self, forCellReuseIdentifier: DoctorRecommendedCell.reuseId)
        table.register(AssociatedEventCell.self, forCellReuseIdentifier: AssociatedEventCell.reuseId)
        table.register(NoOnlineConsultationCell.self, forCellReuseIdentifier: NoOnlineConsultationCell.reuseId)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var tableHeaderView: DoctorDetailHeaderView = {
        let view = DoctorDetailHeaderView()
        view.delegate = self
        return view
    }()
    
    lazy var floatingSegmentBar: SegmentBar = {
        let view = SegmentBar()
        view.isHidden = true
        view.titles = ["医生与我","医生服务"]
        let normolColor = UIColorFromRGB(rgbValue: 0x85888D)
        let selectColor = UIColorFromRGB(rgbValue: 0x333333)
        view.updateConfig { (config) in
            config.textNormalColor(normolColor)
                .textSelectColor(selectColor)
                .textNormalFont(UIFont.systemFont(ofSize: 15))
                .textSelectFont(UIFont.medium(18)!)
                .barMaxWidth(UIScreen.main.bounds.width - 120)
                .barHeight(44)
                .bottomLineHeight(5)
                .bottomLineColor(UIColor(hex: 0xFE5142)).update()
        }
        view.backgroundColor = .white
        view.segmentDelegate = self
        view.layer.shadowColor = UIColor(hex: 0xF96452).cgColor
        view.layer.shadowOpacity = 0.17
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    lazy var segmentBar: SegmentBar = {
        let view = SegmentBar()
        view.titles = ["医生与我","医生服务"]
        let normolColor = UIColorFromRGB(rgbValue: 0x85888D)
        let selectColor = UIColorFromRGB(rgbValue: 0x333333)
        view.updateConfig { (config) in
            config.textNormalColor(normolColor)
                .textSelectColor(selectColor)
                .textNormalFont(UIFont.systemFont(ofSize: 15))
                .textSelectFont(UIFont.medium(18)!)
                .barMaxWidth(UIScreen.main.bounds.width - 120)
                .barHeight(44)
                .bottomLineHeight(5)
                .bottomLineColor(UIColor(hex: 0xFE5142)).update()
        }
        view.backgroundColor = .white
        view.segmentDelegate = self
        return view
    }()
    
}

// MARK: - 自定义SegmentBar的代理
extension DoctorDetailView: SegmentBarDelegate {
    
    func segmentBarDidSelect(segmentBar: SegmentBar, toIndex: NSInteger, fromIndex: NSInteger) {
        syncSegmentSetting(segmentBar, toIndex)
        segmentTag = toIndex
        tableView.reloadData()
    }
    
    /// 同步两个SegmentBar的点击情况
    fileprivate func syncSegmentSetting(_ segmentBar: SegmentBar, _ toIndex: NSInteger) {
        self.segmentBar.setScrollValue(value: CGFloat(toIndex) == 0 ? 0: CGFloat(toIndex) - 0.001)
        self.floatingSegmentBar.setScrollValue(value: CGFloat(toIndex) == 0 ? 0: CGFloat(toIndex) - 0.001)
        self.segmentBar.lastSelectBtn = segmentBar.lastSelectBtn
        self.floatingSegmentBar.lastSelectBtn = segmentBar.lastSelectBtn
    }
}

// MARK: - Cell中点击事件的代理
extension DoctorDetailView: DoctorDetailViewProtocol {
    
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
    
    func clickLoadMore(_ sender: UIButton, atSection: Int) {
        sender.isSelected.toggle()
        expandArray[segmentTag][atSection] = sender.isSelected
        tableView.reloadData()
    }
    
    func followUpPackageBtnAction(_ sender: UIButton, entity: FollowUpPackageEntity) {
        delegate?.followUpPackageBtnAction(sender, entity: entity)
    }
    
    func didClickConsultBtn(_ entity: FollowUpPackageEntity) {
        delegate?.didClickConsultBtn(entity)
    }
    
}

// MARK: - TableView代理
extension DoctorDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return segmentBar
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return shouldHideHeader ? 0 : 50
        }else if segmentTag == 0 {
            if section == 1 {
                if doctorAndMeDataSource.followUpPkgs.count == 0 {
                    return 0
                }
                return doctorAndMeDataSource.articles.count > 0 ? 10 : 0
            }else if section == 2 {
                if doctorAndMeDataSource.followUpPkgs.count == 0 && doctorAndMeDataSource.articles.count == 0 {
                    return 0
                }
                return doctorAndMeDataSource.events.count > 0 ? 10 : 0
            }
        }else if segmentTag == 1 {
            if section == 1 {
                return doctorServiceDataSource.visitSchedule.count > 0 ? 10 : 0
            }else if section == 2 {
                return doctorServiceDataSource.articles.count > 0 ? 10 : 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = LoadMoreFootView()
        foot.delegate = self
        foot.atSection = section
        foot.loadMoreBtn.isSelected = expandArray[segmentTag][section]
        return foot
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if segmentTag == 0 {
            if section == 0 {
                return doctorAndMeDataSource.followUpPkgs.count > 3 ? 40 : 0
            }else if section == 1 {
                return doctorAndMeDataSource.articles.count > 3 ? 40 : 0
            }else if section == 2 {
                return doctorAndMeDataSource.events.count > 3 ? 40 : 0
            }
            
        }else if segmentTag == 1 {
            if section == 0 {
                return doctorServiceDataSource.followUpPkgs.count > 3 ? 40 : 0
            }else if section == 1 {
                return doctorServiceDataSource.visitSchedule.count > 3 ? 40 : 0
            }else if section == 2 {
                return doctorServiceDataSource.articles.count > 3 ? 40 : 0
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // table第一行都是titleCell
        if indexPath.row == 0 {
            return
        }
        
        if segmentTag == 0 {
            // 点击医生推荐我阅读的文章
            if indexPath.section == 1 {
                let entity = doctorAndMeDataSource.articles[indexPath.row - 1]
                print(entity)
            }
        }else if segmentTag == 1 {
            // 点击医生发布的文章
            if indexPath.section == 2 {
                let entity = doctorServiceDataSource.articles[indexPath.row - 1]
                print(entity)
            }
        }
    }
    
}

// MARK: - TableView的数据源代理
extension DoctorDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentTag == 0 {
            switch section {
            case 0:
                let num = doctorAndMeDataSource.followUpPkgs.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 0
                }
            case 1:
                let num = doctorAndMeDataSource.articles.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 0
                }
            case 2:
                let num = doctorAndMeDataSource.events.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 0
                }
            default:
                break
            }
        }else if segmentTag == 1 {
            switch section {
            case 0:
                let num = doctorServiceDataSource.followUpPkgs.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 2
                }
            case 1:
                let num = doctorServiceDataSource.visitSchedule.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 0
                }
            case 2:
                let num = doctorServiceDataSource.articles.count
                if num > 3 && expandArray[segmentTag][section] == false {
                    return 4
                }else {
                    return num > 0 ? num + 1 : 0
                }
            default:
                break
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorDetailSectionHeaderCell.reuseId, for: indexPath) as? DoctorDetailSectionHeaderCell else {
                return UITableViewCell()
            }
            cell.configureData(sectionTitle[segmentTag][indexPath.section])
            return cell
        }else if segmentTag == 0 {
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PurchasedFollowUpPackageCell.reuseId, for: indexPath) as? PurchasedFollowUpPackageCell else {
                    return UITableViewCell()
                }
                let entity = doctorAndMeDataSource.followUpPkgs[indexPath.row - 1]
                cell.configureData(entity)
                cell.delegate = self
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorRecommendedCell.reuseId, for: indexPath) as? DoctorRecommendedCell else {
                    return UITableViewCell()
                }
                let entity = doctorAndMeDataSource.articles[indexPath.row - 1]
                cell.configureData(entity)
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AssociatedEventCell.reuseId, for: indexPath) as? AssociatedEventCell else {
                    return UITableViewCell()
                }
                
                if indexPath.row == doctorAndMeDataSource.events.count {
                    cell.connectingLine.isHidden = true
                }else {
                    let expand = expandArray[segmentTag][indexPath.section]
                    if expand == false && indexPath.row == 3 {
                        cell.connectingLine.isHidden = true
                    }else {
                        cell.connectingLine.isHidden = false
                    }
                }
                
                let entity = doctorAndMeDataSource.events[indexPath.row - 1]
                cell.configureData(entity)
                
                return cell
            default:
                break
            }
        }else if segmentTag == 1 {
            switch indexPath.section {
            case 0:
                
                if doctorServiceDataSource.followUpPkgs.count > 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowUpPackageTableViewCell.reuseId, for: indexPath) as? FollowUpPackageTableViewCell else {
                        return UITableViewCell()
                    }
                    
                    let entity = doctorServiceDataSource.followUpPkgs[indexPath.row - 1]
                    cell.configureData(entity)
                    cell.delegate = self
                    return cell
                }else {
                    // 当在线问诊无数据时默认显示的cell
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: NoOnlineConsultationCell.reuseId, for: indexPath) as? NoOnlineConsultationCell else {
                        return UITableViewCell()
                    }
                    return cell
                }
                
            case 1:
                return UITableViewCell()
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorPostArticleCell.reuseId, for: indexPath) as? DoctorPostArticleCell else {
                    return UITableViewCell()
                }
                cell.configureData(getArticleInfo())
                return cell
            default:
                break
            }
        }
        
        return UITableViewCell()
    }
}

// MARK: - ScrollView的代理
extension DoctorDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 禁止Tableview偏移量小于0时下拉
        var offset = tableView.contentOffset
        if offset.y <= 0 {
            offset.y = 0
        }
        tableView.contentOffset = offset
        
        let offsetY = scrollView.contentOffset.y
        let vc = self.getFirstViewController()
        let segmentOringY = segmentBar.frame.origin.y
        
        let titleOringY = tableHeaderView.doctorName.frame.origin.y +  tableHeaderView.doctorName.frame.size.height
        
        if offsetY > titleOringY {
            vc?.navigationItem.title = doctorInfo.doctorName
        }else {
            vc?.navigationItem.title = ""
        }
        
        if offsetY > segmentOringY {
            floatingSegmentBar.isHidden = shouldHideHeader
        }else {
            floatingSegmentBar.isHidden = true
        }
    }
    
}

// MARK: - 数据源赋值方法
extension DoctorDetailView {
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
    
    fileprivate func getEvetEntity() -> AssociatedEventEntity {
        var entity = AssociatedEventEntity(isDoctor: false)
        entity.eventTime = "2019.6.20"
        entity.eventType = 101
        return entity
    }
    
    func createData() {
        
        let info = DoctorWithMeEntity()
        self.doctorAndMeDataSource = info
        
        for _ in 0...3 {
            var entity = FollowUpPackageEntity()
            entity.packageName = "随访包的名称随访包"
            
            entity.hasUsed = false
            entity.expireDate = "2019年9月1日"
            entity.consultRemainTime = 90
            doctorAndMeDataSource.followUpPkgs.append(entity)
        }
        
        for _ in 0...3 {
            let entity = getArticleInfo()
            doctorAndMeDataSource.articles.append(entity)
        }
        
        for _ in 0...3 {
            let entity = getEvetEntity()
            doctorAndMeDataSource.events.append(entity)
        }
        
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
            doctorServiceDataSource.followUpPkgs.append(entity)
        }
        for _ in 0...3 {
            let entity = VisitScheduleEntity()
            doctorServiceDataSource.visitSchedule.append(entity)
        }
        for _ in 0...3 {
            let entity = getArticleInfo()
            doctorServiceDataSource.articles.append(entity)
        }
        
        if shouldHideHeader {
            segmentTag = 1
        }
        
        let shouldChangeBackgroudColor = doctorServiceDataSource.followUpPkgs.count == 0 && doctorServiceDataSource.visitSchedule.count == 0 && doctorServiceDataSource.articles.count == 0
        
        if shouldChangeBackgroudColor && segmentTag == 1 {
            tableView.backgroundColor = .white
        }else {
            tableView.backgroundColor = .groupTableViewBackground
        }
        
        tableView.reloadData()
        
    }
    
    public func configureData(_ doctorAndMe: DoctorWithMeEntity, _ doctorService: DoctorServiceEntity) {
        self.doctorAndMeDataSource = doctorAndMe
        self.doctorServiceDataSource = doctorService
        
        if shouldHideHeader {
            segmentTag = 1
        }
        
        let shouldChangeBackgroudColor = doctorServiceDataSource.followUpPkgs.count == 0 && doctorServiceDataSource.visitSchedule.count == 0 && doctorServiceDataSource.articles.count == 0
        
        if shouldChangeBackgroudColor && segmentTag == 1 {
            tableView.backgroundColor = .white
        }else {
            tableView.backgroundColor = .groupTableViewBackground
        }
        
        tableView.reloadData()
    }
    
}
