//
//  UserHeaderView.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

class UserHeaderView: UIView {
    
    //MARK: - Properties
    private let profileImageView    = UIImageView()
    private let userNameLabel       = UILabel()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func update(withImageURLString urlString: String, userName: String) {
        #warning("Implement image download functionality")
        profileImageView.image  = UIImage(named: "placeholder-image")
        userNameLabel.text      = userName
    }
    
    //MARK: - UI Configuration
    
   
    
    private func configureUI() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        
        profileImageView.layer.cornerRadius = 19
        profileImageView.clipsToBounds      = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.textColor     = .label
        userNameLabel.font          = UIFont.preferredFont(forTextStyle: .title2)
        userNameLabel.numberOfLines = 1
        userNameLabel.lineBreakMode = .byTruncatingTail
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 38),
            profileImageView.widthAnchor.constraint(equalToConstant: 38),
            
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
    
}
