//
//  Expense.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 19.02.2021.
//

import Foundation

enum ExpenseCategory: String {
    case car            = "car"
    case food           = "food"
    case beauty         = "beauty"
    case donation       = "donation"
    case market         = "market"
    case entertainment  = "entertainment"
}

struct Expense {
    var budgetID: String
    var category: String
    var name: String
    var date: Date
    var amount: Double
}
