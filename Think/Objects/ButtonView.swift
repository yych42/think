//
//  ButtonView.swift
//  Think
//
//  Created by Runkai Zhang on 11/13/18.
//  Copyright © 2018 Yaoyu Chen. All rights reserved.
//

import UIKit

class ButtonView: UIButton {

    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 50
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = #colorLiteral(red: 0.9215686275, green: 0.4823529412, blue: 0.5411764706, alpha: 1)
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 10
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
