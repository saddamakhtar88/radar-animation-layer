//
//  RadarAnimationLayer.swift
//
//  Created by Saddam Akhtar on 26/04/18.
//  Copyright © 2018 Saddam Akhtar. All rights reserved.
//

import UIKit

class RadarAnimationLayer: CAShapeLayer {
    
    var color: UIColor = UIColor.red {
        didSet {
            strokeColor = color.cgColor
            fillColor = color.withAlphaComponent(fillAlpha).cgColor
        }
    }
    
    var animationDuration: CFTimeInterval = 0.4
    var fillAlpha: CGFloat = 0.2 {
        didSet {
            fillColor = color.withAlphaComponent(fillAlpha).cgColor
        }
    }
    
    private var startPoint: CGPoint = CGPoint.zero
    private var diameter: CGFloat = 0.0
    private var startDiameter: CGFloat = 0.0
    
    override init() {
        super.init()
        
        strokeColor = color.cgColor
        fillColor = color.withAlphaComponent(fillAlpha).cgColor
        backgroundColor = UIColor.clear.cgColor
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var ovalPathZero: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(origin: CGPoint(x:startPoint.x - startDiameter/2,
                                                           y:startPoint.y - startDiameter/2),
                                           size: CGSize(width: startDiameter,
                                                        height: startDiameter)))
    }
    
    private var ovalPathMax: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(origin: CGPoint(x:startPoint.x - diameter/2,
                                                           y:startPoint.y - diameter/2),
                                           size: CGSize(width: diameter,
                                                        height: diameter)))
    }
    
    func animate(startPoint: CGPoint,
                 diameter: CGFloat,
                 containerLayer: CALayer,
                 startDiameter: CGFloat = 0.0) {
        
        self.startPoint = startPoint
        self.diameter = diameter
        self.startDiameter = startDiameter
        
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: containerLayer.frame.width,
                                                          height: containerLayer.frame.height))
        
        
        containerLayer.addSublayer(self)
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPathZero.cgPath
        expandAnimation.toValue = ovalPathMax.cgPath
        expandAnimation.duration = animationDuration
        
        let opacityAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.beginTime = animationDuration / 2
        opacityAnimation.duration = animationDuration / 2
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [expandAnimation, opacityAnimation]
        groupAnimation.duration = animationDuration
        
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        add(groupAnimation, forKey: nil)
        
        Timer.scheduledTimer(timeInterval: animationDuration, target: self,
                             selector: #selector(remove),
                             userInfo: nil, repeats: false)
        
    }
    
    @objc func remove() {
        self.removeFromSuperlayer()
    }
    
}
