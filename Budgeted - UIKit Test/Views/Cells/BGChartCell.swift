//
//  BGChartCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 11.02.2021.
//

import UIKit

class BGChartCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier      = "BGChartCell"
    
    private let verticalProgressBar = PlainVerticalProgressBar()
    private let titleLabel          = UILabel()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func set(percentage: CGFloat, title: String) {
        verticalProgressBar.update(with: percentage)
        titleLabel.text = title
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor         = .systemBackground
        selectedBackgroundView  = .none
        configureVerticalProgressBar()
        configureTitleLabel()
    }
    
    private func configureVerticalProgressBar() {
        addSubview(verticalProgressBar)
        verticalProgressBar.update(with: 1)
        
        NSLayoutConstraint.activate([
            verticalProgressBar.topAnchor.constraint(equalTo: topAnchor),
            verticalProgressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalProgressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalProgressBar.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font                         = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.adjustsFontSizeToFitWidth    = true
        titleLabel.minimumScaleFactor           = 0.7
        titleLabel.textAlignment                = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: verticalProgressBar.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
