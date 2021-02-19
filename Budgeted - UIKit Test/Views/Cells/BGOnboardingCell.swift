//
//  OnboardingCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 15.02.2021.
//

import UIKit

class BGOnboardingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier      = "BGOnboardingCell"
    
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
    
    //MARK: - Helpers
    
    func set(for page: OnboardingPage) {
        imageView.image         = UIImage(named: page.imageName)
        titleLabel.text         = page.title
        descriptionLabel.text   = page.description
        descriptionLabel.sizeToFit()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 34)
        ])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font                       = UIFont.systemFont(ofSize: 17, weight: .semibold)
        descriptionLabel.textColor                  = .secondaryLabel
        descriptionLabel.numberOfLines              = 0
        descriptionLabel.adjustsFontSizeToFitWidth  = true
        descriptionLabel.minimumScaleFactor         = 0.6
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 132)
        ])
    }
}
