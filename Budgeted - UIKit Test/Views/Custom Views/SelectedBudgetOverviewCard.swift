//
//  SelectedBudgetOverviewCard.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

protocol SelectedBudgetOverviewCardDelegate: class {
   func didTapBudgetMenu()
}

class SelectedBudgetOverviewCard: UIView {
    
    //MARK: - Properties
    
    weak var delegate: SelectedBudgetOverviewCardDelegate?
    
    private var stackView: UIStackView!
    
    private let selectedBudgetLabel = UILabel()
    private let chevronImageView    = UIImageView()
    private let amountLeftLabel     = BGAttributedLabel()
    private let spentLabel          = UILabel()
    private let progressBar         = PlainHorizontalProgressBar()
    private let percentLabel        = UILabel()
    private let detailLabel         = BGDetailLabel()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func budgetMenuTapped() {
        delegate?.didTapBudgetMenu()
    }
    
    //MARK: - Helpers
    
    func update(with selectedBudget: Budget) {
        selectedBudgetLabel.text    = selectedBudget.name
        percentLabel.text           = BudgetHelper.calculateDisplayPercentage(for: selectedBudget)
        percentLabel.textColor      = BudgetHelper.defineDisplayPercentageColor(for: selectedBudget)
        detailLabel.text            = BudgetHelper.calculateRemainingDays(for: selectedBudget)
        
        progressBar.update(with: BudgetHelper.calculateProgressBarPercentage(for: selectedBudget))
        amountLeftLabel.update(with: BudgetHelper.displayAmountLeft(for: selectedBudget))
    }
    
    func set(initialTitle: String) {
        selectedBudgetLabel.text = initialTitle
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureBackground()
        configureStackView()
        configureSelectedBudgetLabel()
        configureChevronImageView()
        configureAmountLeftLabel()
        configureSpentLabel()
        configureProgressBar()
        configurePercentLabel()
        configureDetailLabel()
    }
    
    private func configureBackground() {
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 8
        layer.applySketchShadow(alpha: 0.05, x: 1, y: 1, blur: 10, spread: 0)
    }
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [selectedBudgetLabel, chevronImageView])
        addSubview(stackView)
        stackView.axis          = .horizontal
        stackView.alignment     = .center
        stackView.spacing       = 3
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(budgetMenuTapped))
        stackView.addGestureRecognizer(tap)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureSelectedBudgetLabel() {
        selectedBudgetLabel.textColor                   = .label
        selectedBudgetLabel.font                        = UIFont.systemFont(ofSize: 20, weight: .medium)
        selectedBudgetLabel.numberOfLines               = 1
        selectedBudgetLabel.adjustsFontSizeToFitWidth   = true
        selectedBudgetLabel.minimumScaleFactor          = 0.9
    }
    
    private func configureChevronImageView() {
        let imageConfiguration      = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
        chevronImageView.image      = UIImage(systemName: "chevron.down", withConfiguration: imageConfiguration)
        chevronImageView.tintColor  = .label
    }
     
    private func configureAmountLeftLabel() {
        addSubview(amountLeftLabel)
        
        NSLayoutConstraint.activate([
            amountLeftLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25),
            amountLeftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            amountLeftLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            amountLeftLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    private func configureSpentLabel() {
        addSubview(spentLabel)
        spentLabel.textColor        = .primaryColor
        spentLabel.font             = UIFont.preferredFont(forTextStyle: .footnote)
        spentLabel.textAlignment    = .right
        spentLabel.numberOfLines    = 1
        spentLabel.text             = "Spent"
        
        spentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spentLabel.bottomAnchor.constraint(equalTo: amountLeftLabel.bottomAnchor),
            spentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            spentLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            spentLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureProgressBar() {
        addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: amountLeftLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            progressBar.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configurePercentLabel() {
        addSubview(percentLabel)
        percentLabel.font           = UIFont.systemFont(ofSize: 13, weight: .semibold)
        percentLabel.numberOfLines  = 1
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            percentLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(lessThanOrEqualTo: progressBar.trailingAnchor, constant: -10),
            percentLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureDetailLabel() {
        addSubview(detailLabel)
        detailLabel.textAlignment = .right
        
        NSLayoutConstraint.activate([
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            detailLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}
