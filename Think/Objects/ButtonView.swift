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
    private var shadow2Layer: CAShapeLayer!
    private var cornerRadius: CGFloat = 50
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = #colorLiteral(red: 0.9294117647, green: 0.07450980392, blue: 0.3803921569, alpha: 1)
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.04
            shadowLayer.shadowRadius = 4
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        if shadow2Layer == nil {
            shadow2Layer = CAShapeLayer()
            
            shadow2Layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadow2Layer.fillColor = fillColor.cgColor
            
            shadow2Layer.shadowColor = #colorLiteral(red: 0.8274509804, green: 0.03529411765, blue: 0.3215686275, alpha: 1)
            shadow2Layer.shadowPath = shadow2Layer.path
            shadow2Layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadow2Layer.shadowOpacity = 0.08
            shadow2Layer.shadowRadius = 7
            
            layer.insertSublayer(shadow2Layer, at: 1)
        }
    }
}
