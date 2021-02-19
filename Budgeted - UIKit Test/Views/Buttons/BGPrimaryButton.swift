//
//  BGPrimaryButton.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

enum BGPrimaryButtonType {
    case main, secondary
}

class BGPrimaryButton: UIButton {
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, type: BGPrimaryButtonType) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        
        switch type {
        case .main:
            setTitleColor(.white, for: .normal)
            backgroundColor = .primaryColor
        case .secondary:
            setTitleColor(UIColor.label, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor.primaryColor.cgColor
        }
        
        configure()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
