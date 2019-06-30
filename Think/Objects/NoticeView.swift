//
//  NoticeView.swift
//  Think
//
//  Created by Runkai Zhang on 11/10/18.
//  Copyright © 2018 Yaoyu Chen. All rights reserved.
//

import UIKit

class NoticeView: UIView {

    private var shadowLayer: CAShapeLayer!
    private var shadow2Layer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.05
            shadowLayer.shadowRadius = 6
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        if shadow2Layer == nil {
            shadow2Layer = CAShapeLayer()
            
            shadow2Layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadow2Layer.fillColor = fillColor.cgColor
            
            shadow2Layer.shadowColor = UIColor.black.cgColor
            shadow2Layer.shadowPath = shadow2Layer.path
            shadow2Layer.shadowOffset = CGSize(width: 0.0, height: 4.5)
            shadow2Layer.shadowOpacity = 0.06
            shadow2Layer.shadowRadius = 4
            
            layer.insertSublayer(shadow2Layer, at: 1)
        }
    }
}
