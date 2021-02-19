//
//  BGValidationAlertType.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 14.02.2021.
//

import Foundation

enum BGValidationAlertType: String {
    case emptyField             = "Please make sure that all the fields have been filled."
    case passwordsNotMatching   = "Please make sure the passwords are identical."
    case wrongPasswordFormat    = "The password format is incorrect, please make sure that your password is at least 6 characters long."
}
