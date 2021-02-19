//
//  OnboardingVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

class OnboardingVC: UIViewController {
    
    //MARK: - Properties
    
    private var collectionView: UICollectionView!
    private let pages: [OnboardingPage] = [OnboardingPage.first, OnboardingPage.second, OnboardingPage.third]
    
    private let previousButton          = BGPrimaryButton(title: "Previous", type: .secondary)
    private let nextButton              = BGPrimaryButton(title: "Next", type: .main)
    private let pageControl             = UIPageControl()
    private let signupButton            = BGPrimaryButton(title: "Sign up", type: .main)
    private let loginButton             = BGPrimaryButton(title: "Log in", type: .secondary)
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc private func didTapPreviousButton() {
        
        // If the user scrolls from the second page to the first page, the previousButton should be removed from the superview
        
        guard pageControl.currentPage != 0 else { return }
        if pageControl.currentPage == 1 { previousButton.removeFromSuperview() }
        pageControl.currentPage -= 1
        let previousIndex = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: previousIndex, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func didTapNextButton() {
        pageControl.currentPage += 1
        let nextIndex = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: nextIndex, at: .centeredHorizontally, animated: true)
        
        // If the user scrolls from the first page to the second page, the previousButton should be configured
        
        /* If the user scrolls to the last page, the scrollability should be disabled, the loginButton and signupButton should be configured and
         the pageControl, previousButton and nextButton should be removed from the superview */
        
        if pageControl.currentPage == 1 { configurePreviousButton() }
        
        if pageControl.currentPage == 2 {
            collectionView.isScrollEnabled = false
            configureLoginButton()
            configureSignupButton()
            pageControl.removeFromSuperview()
            nextButton.removeFromSuperview()
            previousButton.removeFromSuperview()
        }
    }
    
    @objc private func didTapLoginButton() {
        let loginVC = LoginVC()
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc private func didTapSignupButton() {
        let signupVC = SignupVC()
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: signupVC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    //MARK: - UI Configuration
    
    private func configureVC() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureUI() {
        configureCollectionView()
        configureNextButton()
        configurePageControl()
    }
    
    private func configureCollectionView() {
        let layout                  = UICollectionViewFlowLayout()
        layout.scrollDirection      = .horizontal
        layout.minimumLineSpacing   = 0
        collectionView              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(BGOnboardingCell.self, forCellWithReuseIdentifier: BGOnboardingCell.reuseIdentifier)
        collectionView.delegate         = self
        collectionView.dataSource       = self
        collectionView.isPagingEnabled  = true
        collectionView.showsHorizontalScrollIndicator               = false
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 516)
        ])
    }
    
    private func configurePreviousButton() {
        view.addSubview(previousButton)

        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            previousButton.heightAnchor.constraint(equalToConstant: 44),
            previousButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configurePageControl() {
        view.addSubview(pageControl)
        pageControl.currentPageIndicatorTintColor   = .primaryColor
        pageControl.pageIndicatorTintColor          = UIColor.primaryColor.withAlphaComponent(0.25)
        pageControl.numberOfPages                   = pages.count
        pageControl.currentPage                     = 0
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: view.frame.width),
            pageControl.heightAnchor.constraint(equalToConstant: 10)
        ])
        
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 44),
            signupButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewFlowDelegate

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BGOnboardingCell.reuseIdentifier, for: indexPath) as! BGOnboardingCell
        cell.set(for: pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // X represents the horizontal distance at which the scroll ends, in this case every scroll will be equal to the view.frame.width
        
        let x = targetContentOffset.pointee.x
        
        // Since x is always equal to a multiple of view.frame.width, the page the user is on can be found out by diving it by the view.frame.width
        
        let scrollPage = Int(x / view.frame.width)
        
        // If the user scrolls from the first page to the second page, the previousButton should be configured
        // If the user scrolls from the second page to the first page, the previousButton should be removed from the superview
        
        /* If the user scrolls to the last page, the scrollability should be disabled, the loginButton and signupButton should be configured and
         the pageControl, previousButton and nextButton should be removed from the superview */
        
        if pageControl.currentPage == 0 && scrollPage == 1 {
            configurePreviousButton()
        } else if pageControl.currentPage == 1 && scrollPage == 0 {
            previousButton.removeFromSuperview()
        } else if scrollPage == 2 {
            scrollView.isScrollEnabled = false
            configureLoginButton()
            configureSignupButton()
            pageControl.removeFromSuperview()
            previousButton.removeFromSuperview()
            nextButton.removeFromSuperview()
        }
        
        pageControl.currentPage = scrollPage
    }
    
}
