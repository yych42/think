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
    private var cornerRadius: CGFloat = 10
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 4
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
