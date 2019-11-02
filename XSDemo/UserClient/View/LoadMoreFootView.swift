//
//  LoadMoreFootView.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/10/30.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class LoadMoreFootView: UIView {
    
    weak var delegate: DoctorDetailViewProtocol?
    public var atSection: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        self.backgroundColor = .white
        addSubview(loadMoreBtn)
        loadMoreBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(18)
        }
    }
    
    @objc fileprivate func loadMoreAction(_ sender: UIButton) {
        delegate?.clickLoadMore(sender, atSection: atSection ?? 100)
    }
    
    lazy var loadMoreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_open_pages"), for: .normal)
        btn.setImage(UIImage(named: "btn_retract_pages"), for: .selected)
        btn.addTarget(self, action: #selector(loadMoreAction(_:)), for: .touchDown)
        return btn
    }()
}
