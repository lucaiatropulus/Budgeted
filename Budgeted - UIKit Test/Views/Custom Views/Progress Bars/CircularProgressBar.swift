//
//  CircularProgressBar.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

class CircularProgressBar: UIView {
    
    //MARK: - Properties
    
    private let color               = UIColor.systemGray4
    private var progressColor       = UIColor.primaryColor
    private var ringWidth: CGFloat  = 5
    private let progressLayer       = CAShapeLayer()
    private let backgroundMask      = CAShapeLayer()
    
    private var progress: CGFloat = 0.5 {
        didSet { setNeedsDisplay() }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath              = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path         = circlePath.cgPath
        
        progressLayer.path          = circlePath.cgPath
        progressLayer.strokeStart   = 0
        progressLayer.strokeEnd     = progress
        progressLayer.strokeColor   = progressColor.cgColor
    }
    
    //MARK: - Helpers
    
    func update(with value: CGFloat) {
        progressColor   = value < 1 ? UIColor.primaryColor : UIColor.secondaryColor
        progress        = value <= 1 ? value : 1.0
    }
    
    private func setupLayers() {
        backgroundMask.lineWidth    = ringWidth
        backgroundMask.fillColor    = nil
        backgroundMask.strokeColor  = UIColor.black.cgColor
        layer.mask                  = backgroundMask
        
        progressLayer.lineWidth     = ringWidth
        progressLayer.fillColor     = nil
        layer.addSublayer(progressLayer)
        
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    
}
