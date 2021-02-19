//
//  OnboardingInfoView.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

class OnboardingInfoView: UIView {
    
    //MARK: - Properties
    
    private let imageView           = UIImageView()
    private let titleLabel          = UILabel()
    private let descriptionLabel    = UILabel()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withFrame frame: CGRect, imageName: String, title: String, description: String) {
        super.init(frame: frame)
        imageView.image         = UIImage(named: imageName)
        titleLabel.text         = title
        descriptionLabel.text   = description
        configureUI()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font                         = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontSizeToFitWidth    = true
        titleLabel.minimumScaleFactor           = 0.7
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font                       = UIFont.systemFont(ofSize: 17, weight: .semibold)
        descriptionLabel.textColor                  = .secondaryLabel
        descriptionLabel.numberOfLines              = 6
        descriptionLabel.adjustsFontSizeToFitWidth  = true
        descriptionLabel.minimumScaleFactor         = 0.6
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
