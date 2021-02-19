//
//  BGCurrencyListCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 17.02.2021.
//

import UIKit

class BGSimpleListCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier  = "BGSimpleListCell"
    
    private let titleLabel      = UILabel()
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func set(_ title: String) {
        titleLabel.text = title
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .preferredFont(forTextStyle: .body)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

}
