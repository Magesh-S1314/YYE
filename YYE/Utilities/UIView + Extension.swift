//
//  UIView + Extension.swift
//  YYE
//
//  Created by magesh on 22/04/21.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var borderColorView:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidthView:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadow: Bool {
        get{
            self.shadow
        }
        set {
            if newValue {
                layer.applyShadow()
            }
        }
    }
    
}


extension CALayer {
    func applyShadow(color: UIColor = .black, alpha: Float = 0.2, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 2, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
