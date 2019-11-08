//
//  UIView+Extension.swift
//  XSDemo
//
//  Created by 李京珂 on 2019/11/2.
//  Copyright © 2019 李京珂. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerWithRadius(redius:CGFloat){
        self.cornerWithRadiusrectCornerType(radius: redius, rectCornerType: UIRectCorner.allCorners)
    }
    
    func cornerWithRadiusrectCornerType(radius:CGFloat,rectCornerType:UIRectCorner){
        let maskPath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: rectCornerType, cornerRadii: CGSize(width:radius, height:radius))
        let maskLayer = CAShapeLayer.init();
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.cgPath;
        self.layer.mask = maskLayer;
    }
    
    func cornerShadowWithRadius(radius:CGFloat){
        self.layer.cornerRadius = radius;
        self.layer.shadowColor = UIColorFromRGB(rgbValue: 0xc7c7c7).cgColor;
        self.layer.shadowOffset = CGSize(width:0, height:1);//偏移距离
        self.layer.shadowOpacity = 0.5;//不透明度
        self.layer.shadowRadius = 5.0;//半径
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getFirstViewController()->UIViewController?{
        
        for view in sequence(first: self.superview, next: {$0?.superview}){
            
            if let responder = view?.next{
                
                if responder.isKind(of: UIViewController.self){
                    
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
}

extension UIView {
    
    public func addGradientLayer(
        start: CGPoint = CGPoint(x: 0, y: 0), //渐变起点
        end: CGPoint = CGPoint(x: 1, y: 1), //渐变终点
        frame: CGRect,
        colors: [CGColor]
    ) {
        layoutIfNeeded()
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func removeGradientLayer() {
        guard let layers = self.layer.sublayers else { return }
        for layer in layers {
            if layer.isKind(of: CAGradientLayer.self) {
                layer.removeFromSuperlayer()
            }
        }
    }
    
}

extension UIView{
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
