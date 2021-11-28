//
//  UIView.swift
//  LoremPicsum
//
//  Created by Cade May on 11/20/21.
//

import Foundation
import UIKit

extension UIView {
    
    func constrainToFillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let _superview = superview else {return}
        constrain(top: _superview.topAnchor, left: _superview.leftAnchor, bottom: _superview.bottomAnchor, right: _superview.rightAnchor, padding: padding)
    }
    
    func constrainSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func constrain(top: NSLayoutYAxisAnchor?=nil, leading: NSLayoutXAxisAnchor?=nil, bottom: NSLayoutYAxisAnchor?=nil, trailing: NSLayoutXAxisAnchor?=nil, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let _top = top {
            topAnchor.constraint(equalTo: _top, constant: padding.top).isActive = true
        }
        
        if let _leading = leading {
            leadingAnchor.constraint(equalTo: _leading, constant: padding.left).isActive = true
        }
        
        if let _bottom = bottom {
            bottomAnchor.constraint(equalTo: _bottom, constant: -padding.bottom).isActive = true
        }
        
        if let _trailing = trailing {
            trailingAnchor.constraint(equalTo: _trailing, constant: -padding.right).isActive = true
        }
        
    }
    
    func constrain(top: NSLayoutYAxisAnchor?=nil, left: NSLayoutXAxisAnchor?=nil, bottom: NSLayoutYAxisAnchor?=nil, right: NSLayoutXAxisAnchor?=nil, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let _top = top {
            topAnchor.constraint(equalTo: _top, constant: padding.top).isActive = true
        }
        
        if let _left = left {
            leftAnchor.constraint(equalTo: _left, constant: padding.left).isActive = true
        }
        
        if let _bottom = bottom {
            bottomAnchor.constraint(equalTo: _bottom, constant: -padding.bottom).isActive = true
        }
        
        if let _right = right {
            rightAnchor.constraint(equalTo: _right, constant: -padding.right).isActive = true
        }
        
    }
    
    func constrain(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
