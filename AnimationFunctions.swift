//
//  AnimationClass.swift
//  AfriQPay
//
//  Created by Apple on 15/01/20.
//  Copyright © 2020 MindLabs. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func hideItemAnimation (withDuration: Double,item: UIView )
{
    UIView.animate(withDuration: withDuration, animations: {
        item.alpha = 0
    }) { (finished) in
        item.isHidden = finished
    }
}

func unhideItemAnimation (withDuration: Double,item: UIView )
{
    UIView.animate(withDuration: withDuration, animations: {
        item.alpha = 1
    }) { (finished) in
        item.isHidden = false
    }
}


func jumpButtonAnimation(sender: UIButton) {
     let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = NSNumber(value: 1.3)
     animation.duration = 0.1
     animation.repeatCount = 0
     animation.autoreverses = true
    sender.layer.add(animation, forKey: nil)
 }


func movementAnimation(duration:Double,X:CGFloat,Y:CGFloat,item:UIView)
{
    UIView.animate(withDuration: duration) {
      item.transform = CGAffineTransform(translationX: X, y: Y)
        
    }
}


