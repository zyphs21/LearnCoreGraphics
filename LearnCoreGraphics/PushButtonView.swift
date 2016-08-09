//
//  PushButtonView.swift
//  CoreGraphicTest
//
//  Created by Hanson on 16/8/8.
//  Copyright © 2016年 hanson. All rights reserved.
//

import UIKit

@IBDesignable //实时渲染

class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {

        //circle
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        //horizontal plus line
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        
        plusPath.moveToPoint(CGPoint(
            x: bounds.width / 2 - plusWidth / 2 + 0.5,
            y: bounds.height / 2 + 0.5))
        
        plusPath.addLineToPoint(CGPoint(
            x: bounds.width / 2 + plusWidth / 2 + 0.5,
            y: bounds.height / 2 + 0.5))
        
        UIColor.whiteColor().setStroke()
        
        plusPath.stroke()
        
        if isAddButton {
            //Vetical plus line
            plusPath.moveToPoint(CGPoint(
                x: bounds.width / 2 + 0.5,
                y: bounds.height / 2 - plusWidth / 2 + 0.5))
            
            plusPath.addLineToPoint(CGPoint(
                x: bounds.width / 2 + 0.5,
                y: bounds.height / 2 + plusWidth / 2 + 0.5))
            
            plusPath.stroke()
        }
        
    }
 

}
