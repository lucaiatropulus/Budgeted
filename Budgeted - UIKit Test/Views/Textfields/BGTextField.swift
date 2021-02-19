//
//  BGTextField.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

class BGTextField: UITextField {
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String, isEmail: Bool = false, isSecureTextEntry: Bool = false, isNumberField: Bool = false, isLast: Bool = false) {
        super.init(frame: .zero)
        configure()
        self.placeholder                = placeholder
        self.isSecureTextEntry          = isSecureTextEntry
        autocorrectionType = .no
        
        self.returnKeyType              = isLast ? .done : .next
        self.keyboardType               = isEmail ? .emailAddress : .default
        self.keyboardType               = isNumberField ? .numberPad : .default
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomBorder()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        borderStyle             = .none
        keyboardAppearance      = .dark
        autocorrectionType      = .no
        autocapitalizationType  = .none
        returnKeyType           = .default
    }
    
    private func addBottomBorder() {
        let bottomLine              = CALayer()
        bottomLine.backgroundColor  = UIColor.label.withAlphaComponent(0.3).cgColor
        bottomLine.frame            = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        layer.addSublayer(bottomLine)
    }
    
}
