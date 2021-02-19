//
//  BGLoadingView.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 14.02.2021.
//

import UIKit

class BGLoadingView: UIView {
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor         = UIColor.systemBackground.withAlphaComponent(0.8)
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
}
