//
//  BGFormCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 16.02.2021.
//

import UIKit

enum BGFormRowType {
    case plain, option
}

protocol BGFormRowDelegate: class {
    func didSetValueFor(sender: BGFormRow, value: String)
}

class BGFormRow: UIView {
    
    //MARK: - Properties
    
    weak var delegate: BGFormRowDelegate?
    
    private let iconImageView   = UIImageView()
    private let formTitleLabel  = UILabel()
    
    private var formTextField: BGTextField!
    private var selectedOptionLabel: BGDetailLabel!
    private var disclosureIndicator: UIImageView!
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCommonUI()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func update(withCurrency currency: String) {
        selectedOptionLabel.text = currency
    }
    
    func update(withRecurrance recurrance: String) {
        selectedOptionLabel.text = recurrance
    }
    
    func configurePlainRow(withTitle title: String, imageName: String, placeholder: String, isEmail: Bool = false, isSecureTextEntry: Bool = false, isNumberField: Bool = false) {
        formTextField       = BGTextField(placeholder: placeholder, isEmail: isEmail, isSecureTextEntry: isSecureTextEntry, isNumberField: isNumberField)
        iconImageView.image = UIImage(named: imageName)
        formTitleLabel.text = title
        configurePlainUI()
    }
    
    func configureOptionRow(withTitle title: String, imageName: String, currency: String? = nil, reccurence: String? = nil) {
        selectedOptionLabel = BGDetailLabel()
        disclosureIndicator = UIImageView()
        iconImageView.image = UIImage(named: imageName)
        formTitleLabel.text = title
        configureOptionUI()
        
        if title == BGFormRowTitles.currency {
            selectedOptionLabel.text = currency
        } else if title == BGFormRowTitles.recurrence {
            selectedOptionLabel.text = reccurence
        }
    }
    
    //MARK: - UI Configuration
    
    private func configureCommonUI() {
        addSubview(iconImageView)
        addSubview(formTitleLabel)
        iconImageView.contentMode   = .scaleAspectFit
        formTitleLabel.font         = .systemFont(ofSize: 13, weight: .medium)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints     = false
        formTitleLabel.translatesAutoresizingMaskIntoConstraints    = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            formTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            formTitleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            formTitleLabel.widthAnchor.constraint(equalToConstant: 80),
            formTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePlainUI() {
        addSubview(formTextField)
        formTextField.delegate = self
        formTextField.font = .systemFont(ofSize: 13, weight: .medium)
        formTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formTextField.centerYAnchor.constraint(equalTo: formTitleLabel.centerYAnchor),
            formTextField.leadingAnchor.constraint(equalTo: formTitleLabel.trailingAnchor, constant: 5),
            formTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            formTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func configureOptionUI() {
        addSubview(selectedOptionLabel)
        addSubview(disclosureIndicator)
        selectedOptionLabel.textAlignment   = .right
        let configuration                   = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 10), scale: .medium)
        disclosureIndicator.image           = UIImage(systemName: "chevron.forward")?.withConfiguration(configuration)
        disclosureIndicator.tintColor       = .secondaryLabel
        
        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disclosureIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            disclosureIndicator.centerYAnchor.constraint(equalTo: formTitleLabel.centerYAnchor),
            disclosureIndicator.heightAnchor.constraint(equalToConstant: 10),
            disclosureIndicator.widthAnchor.constraint(equalToConstant: 10),
            
            selectedOptionLabel.centerYAnchor.constraint(equalTo: formTitleLabel.centerYAnchor),
            selectedOptionLabel.leadingAnchor.constraint(equalTo: formTitleLabel.trailingAnchor, constant: 5),
            selectedOptionLabel.trailingAnchor.constraint(equalTo: disclosureIndicator.leadingAnchor, constant: -5),
            selectedOptionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

//MARK: - UITextFieldDelegate

extension BGFormRow: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let value = textField.text, !value.isEmpty else { return }
        delegate?.didSetValueFor(sender: self, value: value)
    }
    
    
}



