//
//  BGOnboardingLoadingView.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 15.02.2021.
//

import UIKit
import Lottie

class BGOnboardingLoadingView: UIView {
    
    //MARK: - Properties
    
    private let containerView   = UIView()
    private let animationView   = AnimationView()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func startAnimation() {
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
        configureContainerView()
        configureAnimationView()
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        containerView.backgroundColor       = .primaryColor
        containerView.layer.cornerRadius    = 25
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 100),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureAnimationView() {
        containerView.addSubview(animationView)
        guard let filePath          = Bundle.main.resourcePath else { return }
        animationView.animation     = Animation.filepath(filePath + "/27-loading.json")
        animationView.contentMode   = .scaleAspectFill
        animationView.clipsToBounds = true
        animationView.loopMode      = .loop
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: containerView.topAnchor),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
