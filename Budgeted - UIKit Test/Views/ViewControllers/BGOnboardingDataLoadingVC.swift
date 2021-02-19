//
//  BGOnboardingDataLoadingVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 15.02.2021.
//

import UIKit

class BGOnboardingDataLoadingVC: UIViewController {
    
    //MARK: - Properties
    
    var loadingView: BGOnboardingLoadingView!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helpers
    
    func presentBGOnboardingLoadinViewOnMainThread() {
        DispatchQueue.main.async {
            self.loadingView        = BGOnboardingLoadingView(frame: self.view.frame)
            self.loadingView.alpha  = 0
            self.view.addSubview(self.loadingView)
            
            UIView.animate(withDuration: 0.25) { self.loadingView.alpha = 1 }
            self.loadingView.startAnimation()
        }
    }
    
    func dismissBGOnboardingLoadingViewOnMainThread() {
        DispatchQueue.main.async {
            self.loadingView.stopAnimation()
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }

}
