//
//  BGUserOptionsCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 10.02.2021.
//

import UIKit

class BGUserOptionsCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier  = "BGUserOptionsCell"
    
    private let iconImageView   = UIImageView()
    private let optionLabel     = UILabel()
    private let separatorView   = UIView()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func set(iconName: String, optionName: String) {
        let iconConfiguration   = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        iconImageView.image     = UIImage(systemName: iconName, withConfiguration: iconConfiguration)
        optionLabel.text        = optionName
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor = .systemBackground
        selectionStyle  = .none
        configureIconImageView()
        configureOptionLabel()
        configureSeparatorView()
    }
    
    private func configureIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.tintColor = .label
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureOptionLabel() {
        addSubview(optionLabel)
        
        optionLabel.font            = .preferredFont(forTextStyle: .title3)
        optionLabel.numberOfLines   = 1
        
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            optionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureSeparatorView() {
        addSubview(separatorView)
        
        separatorView.backgroundColor   = .label
        separatorView.alpha             = 0.25
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            separatorView.leadingAnchor.constraint(equalTo: optionLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}
