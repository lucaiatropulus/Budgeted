//
//  BudgetListModal.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 11.02.2021.
//

import UIKit

protocol BudgetListModalDelegate: class {
    func didSelectBudget(budget: Budget)
    func didTapAddBugetButton()
}

class BudgetListModal: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: BudgetListModalDelegate?
    
    private let topBarView              = UIView()
    private let titleLabel              = UILabel()
    private let addBudgetButton         = UIButton()
    private let budgetListTableView     = UITableView()
    
    private var hasSetPointOrigin       = false
    private var pointOrigin: CGPoint?
    
    private var budgets: [Budget] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        setupPanGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    init(budgets: [Budget]) {
        super.init(nibName: nil, bundle: nil)
        self.budgets = budgets
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func addBudgetButtonTapped() {
        delegate?.didTapAddBugetButton()
        dismiss(animated: true)
    }
    
    @objc private func swipeToDismissModal(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Only let the user swipe down
        
        guard translation.y >= 0  else { return }
        
        // Setting the origin to x = 0 to prevent the user from swiping the view sideways, setting y to be equal to the original position + the amount the user swiped down
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        // Checking if the swipe has ended
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            
            // If the velocity was fast enough, dismiss the VC, otherwise animate the view back to the original position
            
            if dragVelocity.y > 1300 {
                self.dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    //MARK: - Helpers
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeToDismissModal))
        view.addGestureRecognizer(panGesture)
    }
    
    //MARK: - UI Configuration
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureUI() {
        configureTopBarView()
        configureTitleLabel()
        configureAddBudgetButton()
        configureBudgetListTableView()
    }
    
    private func configureTopBarView() {
        view.addSubview(topBarView)
        topBarView.backgroundColor      = .label
        topBarView.alpha                = 0.25
        topBarView.layer.cornerRadius   = 2.5
        
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            topBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 5),
            topBarView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font             = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.numberOfLines    = 1
        titleLabel.text             = "Budgets"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureAddBudgetButton() {
        view.addSubview(addBudgetButton)
        addBudgetButton.setTitle("+ Add Budget", for: .normal)
        addBudgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        addBudgetButton.contentHorizontalAlignment = .trailing
        addBudgetButton.setTitleColor(.primaryColor, for: .normal)
        addBudgetButton.addTarget(self, action: #selector(addBudgetButtonTapped), for: .touchUpInside)
        
        addBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addBudgetButton.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 15),
            addBudgetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addBudgetButton.leadingAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: 5),
            addBudgetButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureBudgetListTableView() {
        view.addSubview(budgetListTableView)
        
        budgetListTableView.register(BGBudgetListCell.self, forCellReuseIdentifier: BGBudgetListCell.reuseIdentifier)
        budgetListTableView.delegate           = self
        budgetListTableView.dataSource         = self
        budgetListTableView.separatorStyle     = .none
        budgetListTableView.isScrollEnabled    = false
        
        budgetListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            budgetListTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            budgetListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            budgetListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            budgetListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    

}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension BudgetListModal: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BGBudgetListCell.reuseIdentifier, for: indexPath) as! BGBudgetListCell
        cell.set(budget: budgets[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectBudget(budget: budgets[indexPath.row])
        dismiss(animated: true)
    }
}
    
