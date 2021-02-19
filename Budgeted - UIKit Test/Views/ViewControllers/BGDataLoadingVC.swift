//
//  BGDataLoadingVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 14.02.2021.
//

import UIKit

class BGDataLoadingVC: UIViewController {
    
    //MARK: - Properties
    
    var loadingView: BGLoadingView!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helpers
    
    func presentBGLoadingViewOnMainThread() {
        DispatchQueue.main.async {
            self.loadingView        = BGLoadingView(frame: self.view.frame)
            self.loadingView.alpha  = 0
            self.view.addSubview(self.loadingView)

            UIView.animate(withDuration: 0.25) { self.loadingView.alpha = 1 }
        }
    }

    func dismissBGLoadingViewOnMainThread() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }

}
