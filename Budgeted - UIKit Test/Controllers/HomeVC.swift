//
//  HomeVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 08.02.2021.
//

import UIKit

class HomeVC: BGDataLoadingVC {
    
    //MARK: - Properties
    
    private var user: User?
    private var selectedBudget: Budget?
    private var budgets: [Budget] = []
    
    private let userHeaderView                      = UserHeaderView()
    private let selectedBudgetOverviewCard          = SelectedBudgetOverviewCard()
    private var dailySpendingChartView              = BGDailySpendingChartView()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        getDataForLoggedInUser()
    }
    
    //MARK: - Actions
    
    @objc private func presentUserOptionsModal() {
        guard let user = user else { return }
        let modal                       = UserOptionsModal(with: user)
        modal.modalPresentationStyle    = .custom
        modal.transitioningDelegate     = self
        self.present(modal, animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureVC() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func getDataForLoggedInUser() {
        presentBGLoadingViewOnMainThread()
        APIManager.getDataForLoggedInUser { [weak self] result in
            guard let self = self else { return }
            self.dismissBGLoadingViewOnMainThread()
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                    self.userHeaderView.update(withImageURLString: "", userName: user.fullname)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let title = "Server Error"
                    let alert = self.createAlert(withTitle: title, message: error.localizedDescription)
                    self.present(alert, animated: true)
                }
        }
    }
}
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureUserHeaderView()
        configureSelectedBudgetOverviewCard()
        confiureDailySpendingChartView()
    }
    
    private func configureUserHeaderView() {
        view.addSubview(userHeaderView)
        userHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentUserOptionsModal))
        userHeaderView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            userHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userHeaderView.heightAnchor.constraint(equalToConstant: 38),
            userHeaderView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureSelectedBudgetOverviewCard() {
        view.addSubview(selectedBudgetOverviewCard)
        selectedBudgetOverviewCard.set(initialTitle: "Create Budget")
        
        selectedBudgetOverviewCard.delegate = self
        
        NSLayoutConstraint.activate([
            selectedBudgetOverviewCard.topAnchor.constraint(equalTo: userHeaderView.bottomAnchor, constant: 30),
            selectedBudgetOverviewCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedBudgetOverviewCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectedBudgetOverviewCard.heightAnchor.constraint(equalToConstant: 183)
        ])
    }
    
    private func confiureDailySpendingChartView() {
        view.addSubview(dailySpendingChartView)
        dailySpendingChartView.set(collectionViewDelegate: self, collectionViewDataSource: self)
        
        NSLayoutConstraint.activate([
            dailySpendingChartView.topAnchor.constraint(equalTo: selectedBudgetOverviewCard.bottomAnchor, constant: 20),
            dailySpendingChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dailySpendingChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dailySpendingChartView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    

}

//MARK: - UIViewControllerTransitionDelegate

extension HomeVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BGModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

//MARK: - SelectedBudgetOverviewCardDelegate

extension HomeVC: SelectedBudgetOverviewCardDelegate {
    func didTapBudgetMenu() {
        let modal                       = BudgetListModal(budgets: budgets)
        modal.delegate                  = self
        modal.modalPresentationStyle    = .custom
        modal.transitioningDelegate     = self
        self.present(modal, animated: true)
    }
}

//MARK: - BudgetListModalDelegate

extension HomeVC: BudgetListModalDelegate {
    
    func didTapAddBugetButton() {
        DispatchQueue.main.async {
            let budgetCreationVC = BGBudgetCreationVC()
            budgetCreationVC.delegate = self
            budgetCreationVC.title = "Add a new budget"
            let budgetCreationNC = UINavigationController(rootViewController: budgetCreationVC)
            self.present(budgetCreationNC, animated: true)
        }
    }
    
    func didSelectBudget(budget: Budget) {
        selectedBudget = budget
        guard let selectedBudget = selectedBudget else { return }
        selectedBudgetOverviewCard.update(with: selectedBudget)
        dailySpendingChartView.update(withExpenses: [], in: selectedBudget)
    }
}

//MARK: - BGBudgetCreationVCDelegate

extension HomeVC: BGBudgetCreationVCDelegate {
    func didCreateNewBudget(budget: Budget) {
        presentBGLoadingViewOnMainThread()
        APIManager.save(budget: budget) { [weak self] error in
            guard let self = self else { return }
            self.dismissBGLoadingViewOnMainThread()
            if let error = error {
                DispatchQueue.main.async {
                    let title = "Unable to create"
                    let alert = self.createAlert(withTitle: title, message: error.localizedDescription)
                    self.present(alert, animated: true)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.budgets.append(budget)
                self.selectedBudgetOverviewCard.update(with: budget)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BGChartCell.reuseIdentifier, for: indexPath) as! BGChartCell
        cell.set(percentage: 1, title: "Today")
        return cell
    }
    
}
