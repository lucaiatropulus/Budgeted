//
//  TestVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 15.02.2021.
//

import UIKit

class TestVC: BGOnboardingDataLoadingVC {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureButton()
    }
    
    @objc func didPressButton() {
        presentBGOnboardingLoadinViewOnMainThread()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismissBGOnboardingLoadingViewOnMainThread()
        }
    }
    
    func configureButton() {
        view.addSubview(button)
        button.setTitle("Press", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


}
