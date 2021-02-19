//
//  CALayer Ext.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 09.02.2021.
//

import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = .black, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        masksToBounds   = false
        shadowColor     = color.cgColor
        shadowOpacity   = alpha
        shadowOffset    = CGSize(width: x, height: y)
        shadowRadius    = blur / 2.0
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
