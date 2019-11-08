//
//  DoctorServiceHeaderView.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/6.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

class DoctorServiceHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.addCorner(conrners: [.topLeft, .topRight], radius: 10)
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
}

