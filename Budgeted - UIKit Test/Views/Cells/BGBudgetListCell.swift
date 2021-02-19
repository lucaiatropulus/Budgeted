//
//  BGBudgetListCell.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 11.02.2021.
//

import UIKit

class BGBudgetListCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier      = "BGBudgetListCell"
    
    private var stackView: UIStackView!
    
    private let progressCircle      = CircularProgressBar()
    private let percentageLabel     = UILabel()
    private let budgetTitleLabel    = UILabel()
    private let detailLabel         = BGDetailLabel()
    private let amountLeftLabel     = BGAttributedLabel()
    
    //MARK: - Lifecycle
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func set(budget: Budget) {
        budgetTitleLabel.text   = budget.name
        percentageLabel.text    = BudgetHelper.calculateDisplayPercentage(for: budget)
        detailLabel.text        = BudgetHelper.calculateRemainingDays(for: budget)
        
        amountLeftLabel.update(with: BudgetHelper.displayAmountLeft(for: budget))
        progressCircle.update(with: BudgetHelper.calculateProgressBarPercentage(for: budget))
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor = .systemBackground
        selectionStyle  = .none
        configureProgressCircle()
        configurePercentageLabel()
        configureStackView()
        configureBudgetTitleLabel()
        configureAmountLeftLabel()
    }
    
    private func configureProgressCircle() {
        addSubview(progressCircle)
        
        NSLayoutConstraint.activate([
            progressCircle.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            progressCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressCircle.heightAnchor.constraint(equalToConstant: 45),
            progressCircle.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [budgetTitleLabel, detailLabel])
        addSubview(stackView)
        stackView.axis      = .vertical
        stackView.alignment = .leading
        stackView.spacing   = 2
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: progressCircle.centerYAnchor, constant: -1),
            stackView.leadingAnchor.constraint(equalTo: progressCircle.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func configurePercentageLabel() {
        addSubview(percentageLabel)
        percentageLabel.font            = UIFont.systemFont(ofSize: 12, weight: .medium)
        percentageLabel.numberOfLines   = 1
        percentageLabel.textAlignment   = .center
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            percentageLabel.centerXAnchor.constraint(equalTo: progressCircle.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: progressCircle.centerYAnchor),
            percentageLabel.heightAnchor.constraint(equalToConstant: 16),
            percentageLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureBudgetTitleLabel() {
        budgetTitleLabel.font                       = UIFont.systemFont(ofSize: 17, weight: .medium)
        budgetTitleLabel.adjustsFontSizeToFitWidth  = true
        budgetTitleLabel.minimumScaleFactor         = 0.8
        
        budgetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAmountLeftLabel() {
        addSubview(amountLeftLabel)
        amountLeftLabel.textAlignment = .right
        
        NSLayoutConstraint.activate([
            amountLeftLabel.centerYAnchor.constraint(equalTo: progressCircle.centerYAnchor),
            amountLeftLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            amountLeftLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            amountLeftLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
