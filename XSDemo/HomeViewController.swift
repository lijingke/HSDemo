//
//  HomeViewController.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    fileprivate func configureNav() {
        navigationItem.title = "XSDemo"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font : UIFont.semibold(17)!]
        
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav()
    }
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        view.addSubview(userEtryBtn)
        view.addSubview(doctorEntryBtn)
        
        userEtryBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        doctorEntryBtn.snp.makeConstraints { (make) in
            make.top.equalTo(userEtryBtn.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func clickAction(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            let vc = DoctorDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1001:
            let vc = DoctorDetailForDoctorViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

    
    lazy var userEtryBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1000
        btn.setTitle("用户端入口", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage(named: "doctor_page_btn_setting_bg"), for: .normal)
        btn.addTarget(self, action: #selector(clickAction(_:)), for: .touchDown)
        return btn
    }()
    
    lazy var doctorEntryBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1001
        btn.setTitle("医生端入口", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage(named: "doctor_page_btn_setting_bg"), for: .normal)
        btn.addTarget(self, action: #selector(clickAction(_:)), for: .touchDown)
        return btn
    }()

}

