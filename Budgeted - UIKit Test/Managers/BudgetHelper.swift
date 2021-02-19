//
//  BudgetManager.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 10.02.2021.
//

import UIKit

struct BudgetHelper {
    
    static func calculateProgressBarPercentage(for budget: Budget) -> CGFloat {
        return CGFloat(budget.spentAmount / budget.budgetedAmount)
    }
    
    static func calculateDisplayPercentage(for budget: Budget) -> String {
        return String(format: "%.0f", 100 * budget.spentAmount / budget.budgetedAmount) + "%"
    }
    
    static func defineDisplayPercentageColor(for budget: Budget) -> UIColor {
        return calculateProgressBarPercentage(for: budget) >= 0.1 ? UIColor.white : UIColor.black
    }
    
    static func calculateRemainingDays(for budget: Budget) -> String {
        
        let remainingHours  = budget.resetDate.timeIntervalSinceNow / 3600
        let remainingDays   = remainingHours / 24
        return String(format: "%.0f", remainingDays) + " days remaining"
    }
    
    static func displayAmountLeft(for budget: Budget) -> NSAttributedString {
    
        let firstAttributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor : UIColor.label]
        let mutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f", budget.budgetedAmount - budget.spentAmount), attributes: firstAttributes)
        
        let secondAttributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor : UIColor.label]
        let secondAttributedString = NSAttributedString(string: " \(budget.currencyType) left", attributes: secondAttributes)
        
        mutableAttributedString.append(secondAttributedString)
        
        return mutableAttributedString
    }
    
    static func displayAmountSpent(for expenses: [Expense], in selectedBudget: Budget) -> NSAttributedString {
        let totalSpent = expenses.reduce(0) { $0 + $1.amount }
        
        let firstAttributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor : UIColor.secondaryColor]
        let mutableAttributedString = NSMutableAttributedString(string: String(format: "%.2f", totalSpent), attributes: firstAttributes)
        
        let secondAttributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor : UIColor.label]
        let secondAttributedString = NSAttributedString(string: " \(selectedBudget.currencyType) spent Today", attributes: secondAttributes)
        
        mutableAttributedString.append(secondAttributedString)
        
        return mutableAttributedString
    }
    
}
