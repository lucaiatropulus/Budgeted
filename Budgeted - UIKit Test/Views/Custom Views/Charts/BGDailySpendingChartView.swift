//
//  BGDailySpendingChartView.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 11.02.2021.
//

import UIKit

class BGDailySpendingChartView: UIView {
    
    //MARK: - Properties
    
    private var chartCollectionView: UICollectionView!
    private let amountSpentLabel    = BGAttributedLabel()
    
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
    
    //MARK: - Helpers
    
    private func createUICollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout                  = UICollectionViewFlowLayout()
        let itemSize                = CGSize(width: 30, height: 226)
        layout.itemSize             = itemSize
        return layout
    }
    
    func set(collectionViewDelegate: UICollectionViewDelegate, collectionViewDataSource: UICollectionViewDataSource) {
        chartCollectionView.delegate    = collectionViewDelegate
        chartCollectionView.dataSource  = collectionViewDataSource
    }
    
    func update(withExpenses expenses: [Expense], in selectedBudget: Budget) {
        amountSpentLabel.update(with: BudgetHelper.displayAmountSpent(for: expenses, in: selectedBudget))
        chartCollectionView.reloadData()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 8
        layer.applySketchShadow(alpha: 0.05, x: 1, y: 1, blur: 10, spread: 0)
        configureChartCollectionView()
        configureAmountSpentLabel()
    }
    
    private func configureChartCollectionView() {
        chartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createUICollectionViewFlowLayout())
        addSubview(chartCollectionView)
        chartCollectionView.register(BGChartCell.self, forCellWithReuseIdentifier: BGChartCell.reuseIdentifier)
        chartCollectionView.isScrollEnabled = false
        chartCollectionView.backgroundColor = .systemBackground
        
        chartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            chartCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            chartCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            chartCollectionView.heightAnchor.constraint(equalToConstant: 226)
        ])
    }
    
    private func configureAmountSpentLabel() {
        addSubview(amountSpentLabel)
        amountSpentLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            amountSpentLabel.topAnchor.constraint(equalTo: chartCollectionView.bottomAnchor, constant: 15),
            amountSpentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amountSpentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            amountSpentLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
