//
//  BGDetailLabel.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

class BGAttributedLabel: UILabel {
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    
    func update(with value: NSAttributedString) {
        attributedText              = value
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.6
    }
    
    //MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
