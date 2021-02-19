//
//  UIViewController Ext.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 19.02.2021.
//

import UIKit

extension UIViewController {
    func createAlert(withTitle title: String, message: String) -> UIAlertController {
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(dismissAction)
        return alert
    }
}
