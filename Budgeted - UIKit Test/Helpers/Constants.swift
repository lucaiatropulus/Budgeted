//
//  Constants.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 17.02.2021.
//

import Foundation

struct Icons {
    static let amount   = "amount"
    static let budget   = "budget"
    static let calendar = "calendar"
    static let currency = "currency"
}

enum Currencies: String {
    case eur    = "eur"
    case ron    = "ron"
    case dollar = "usd"
    
    static let list: [Currencies] = [Currencies.ron, Currencies.eur, Currencies.dollar]
}

enum Recurrences: String {
    case weekly     = "Weekly"
    case monthly    = "Monthly"
    case yearly     = "Yearly"
    
    static let list: [Recurrences] = [Recurrences.weekly, Recurrences.monthly, Recurrences.yearly]
}

struct BGFormRowTitles {
    static let name         = "Budget"
    static let currency     = "Currency"
    static let recurrence   = "Recurrence"
    static let amount       = "Amount"
}

struct BGFormRowPlaceholders {
    static let name     = "Budget name"
    static let amount   = "Budgeted amount"
}

struct OnboardingPage {
    
    let imageName: String
    let title: String
    let description: String
    
    
    static let first = OnboardingPage(imageName: "calculator_image",
                                                              title: "No need for a calculator",
                                                              description: "Budgeted takes care of all the work for you, add your expenses on the go and get real time updates on your budgets.")
    static let second = OnboardingPage(imageName: "data_image",
                                                               title: "Manage multiple budgets",
                                                               description: "Sometimes a single budget isn’t the best choice for your needs.\n\nBudgeted allows you to have multiple budgets and check all of them at a glance.")
    static let third = OnboardingPage(imageName: "savings_image",
                                                              title: "Budget better, save more",
                                                              description: "Saving money for a rainy day should be a priority for everyone.\n\nBudgeted allows you to budget better and save money in the process.")
}
