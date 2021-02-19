//
//  BGModalPresentationController.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 10.02.2021.
//

import UIKit

class BGModalPresentationController: UIPresentationController {

    //MARK: - Properties
    
    let blurEffectView: UIView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - Lifecycle
    
    // Create blur effect which will be applied to the containerView (the view below the presented view)
    // Apply tap gesture recognizer to the blurEffectView that dismissed the presented view
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let backgroundColor             = UIColor.black.withAlphaComponent(0.9)
        blurEffectView                  = UIView()
        blurEffectView.backgroundColor  = backgroundColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Customize the origin and the height of the presented view
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height - 340), size: CGSize(width: self.containerView!.frame.width, height: 340))
    }
    
    // Add the blurEffectView to the background while the view is presented
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0.7
        }, completion: { _ in })
    }
    
    // Remove blurEffectView from the background when the presented view is dismissed
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0
        }, completion: { _ in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    // Round the corners of the presented view
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    // Layout has ended
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    //MARK: - Actions
    
    // Dismiss the presented view on tap
    
    @objc private func dismissController() {
        self.presentedViewController.dismiss(animated: true)
    }
}
