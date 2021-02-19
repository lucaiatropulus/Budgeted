//
//  BGDetailLabel.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 09.02.2021.
//

import UIKit

class BGDetailLabel: UILabel {
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func update(with string: String) {
        text = string
    }
    
    //MARK: - Configuration
    
    private func configure() {
        textColor                   = .secondaryLabel
        font                        = UIFont.preferredFont(forTextStyle: .footnote)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.8
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
