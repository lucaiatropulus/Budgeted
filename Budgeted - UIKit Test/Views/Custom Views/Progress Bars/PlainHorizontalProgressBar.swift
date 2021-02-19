//
//  PlainHorizontalProgressBar.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

class PlainHorizontalProgressBar: UIView {
    
    //MARK: - Properties
    
    private let baseColor                   = UIColor.systemGray4
    private var progressColor               = UIColor.primaryColor
    private let progressLayer               = CALayer()
    
    // Everytime progress updates, it forces the view to redraw for the new value
    
    private var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = baseColor
        layer.addSublayer(progressLayer)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Create a rounded rectangle mask and apply it to the view's layer
    // Create a progress rectangle that has a width equal to the procent of progress out of the whole width, set the progressLayer's frame to be equal to this rect
    // Add the progressColor to the progressLayer and a corner radius
    
    override func draw(_ rect: CGRect) {
        let backgroundMask              = CAShapeLayer()
        backgroundMask.path             = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask                      = backgroundMask
        
        let progressRect                = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame             = progressRect
        progressLayer.backgroundColor   = progressColor.cgColor
        progressLayer.cornerRadius      = 8
    }
    
    //MARK: - Helpers
    
    // Everytime there is a new value for the progress, if the value is less than 100% of the budget, set the progressColor to the primaryColor (green), else set it secondary (red)
    // The progress should always be less or equal to 1.0, it if isn't, set it to 1.0
    
    func update(with value: CGFloat) {
        progressColor   = value < 1 ? UIColor.primaryColor : UIColor.secondaryColor
        progress        = value <= 1 ? value : 1.0
    }
    
    
}
