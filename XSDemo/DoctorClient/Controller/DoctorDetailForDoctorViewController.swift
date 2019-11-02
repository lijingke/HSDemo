//
//  DoctorDetailForDoctorViewController.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/1.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorDetailForDoctorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x4882FF)
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
    
    lazy var mainView: DoctorDetailForDoctorView = {
        let view = DoctorDetailForDoctorView()
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

extension DoctorDetailForDoctorViewController: DoctorDetailViewForDoctorProtocol {
    
    // 已在View层处理，Controller不做处理
    func doctorInfoBtnAction(_ sender: UIButton) {
    }
    
    // 已在View层处理，Controller不做处理
    func clickLoadMore(_ sender: UIButton, atSection: Int) {
    }
    
    func doctorDidClickOpenService(_ btnType: Int) {
        switch btnType {
        case 1000:
            print("开通在线问诊")
        case 1001:
            print("设置出诊表")
        default:
            break
        }
    }
}
