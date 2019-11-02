//
//  DoctorDetailViewController.swift
//  HXSDemo
//
//  Created by 李京珂 on 2019/10/28.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorDetailViewController: UIViewController {
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0xFF7056)
        
        navLine()?.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font : UIFont.semibold(20)!]
        
        let item = UIBarButtonItem.init(customView:rightBtn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navLine()?.isHidden = false
    }
    
    @objc func shareAction(_ sender: UIButton) {
        print("点击了分享")
    }
    
    lazy var mainView: DoctorDetailView = {
        let view = DoctorDetailView()
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    lazy var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_share"), for: .normal)
        btn.addTarget(self, action: #selector(shareAction(_:)), for: .touchDown)
        return btn
    }()
}

extension DoctorDetailViewController: DoctorDetailViewProtocol {
    func doctorInfoBtnAction(_ sender: UIButton) {
    }
    
    func clickLoadMore(_ sender: UIButton, atSection: Int) {
    }
    
    func followUpPackageBtnAction(_ sender: UIButton, entity: FollowUpPackageEntity) {
        switch sender.tag {
        case 1000:
            print("点击了预定价格\(entity.price ?? 0)")
        case 1001:
            print("点击了收藏\(entity.isCollected!)")
        default:
            break
        }
    }
    
    func didClickConsultBtn(_ entity: FollowUpPackageEntity) {
        print(entity)
    }
    
}
