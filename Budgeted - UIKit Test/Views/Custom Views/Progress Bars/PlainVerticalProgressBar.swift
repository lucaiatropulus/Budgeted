//
//  TestVerticalProgressBar.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 11.02.2021.
//

import UIKit

class PlainVerticalProgressBar: UIView {
    
    //MARK: - Properties
    
    private var progressColor               = UIColor.primaryColor
    private let progressLayer               = CALayer()
    
    // Everytime progress updates, it forces the view to redraw for the new value
    
    private var progress: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.addSublayer(progressLayer)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Since the origin is at .zero, which is in the top left corner of the rect, the layer needs to be rotated by 180 degrees along the Z axis to start the progress from the bottom
    // Create a progress rectangle that has a width equal to the procent of progress out of the whole height, set progress's frame equal to the progressRect
    // Add the progressColor to the progressLayer and a corner radius
    
    override func draw(_ rect: CGRect) {
        layer.transform                 = CATransform3DMakeRotation(CGFloat.pi, 0, 0, -1)
        let progressRect                = CGRect(origin: .zero, size: CGSize(width: rect.width, height: rect.height * progress))
        progressLayer.frame             = progressRect
        progressLayer.backgroundColor   = progressColor.cgColor
        progressLayer.cornerRadius      = 8
        
    }
    
    //MARK: - Helpers
    
    // The progress should always be less or equal to 1.0, it if isn't, set it to 1.0
    
    func update(with value: CGFloat) {
        progress        = value <= 1 ? value : 1.0
    }
    
    
}
