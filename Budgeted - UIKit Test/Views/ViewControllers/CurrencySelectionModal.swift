//
//  CurrencySelectionModal.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 17.02.2021.
//

import UIKit

protocol CurrencySelectionModalDelegate: class {
    func didSelectCurrency(_ currency: String)
}

class CurrencySelectionModal: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: CurrencySelectionModalDelegate?
    
    private let topBarView                  = UIView()
    private let titleLabel                  = UILabel()
    private let currencyListTableView       = UITableView()
    
    private var hasSetPointOrigin           = false
    private var pointOrigin: CGPoint?
    
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
    
    //MARK: - Actions
    
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
        titleLabel.text             = "Currencies"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureBudgetListTableView() {
        view.addSubview(currencyListTableView)
        
        currencyListTableView.register(BGSimpleListCell.self, forCellReuseIdentifier: BGSimpleListCell.reuseIdentifier)
        currencyListTableView.delegate           = self
        currencyListTableView.dataSource         = self
        currencyListTableView.separatorStyle     = .none
        currencyListTableView.isScrollEnabled    = true
        
        currencyListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyListTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            currencyListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    

}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension CurrencySelectionModal: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currencies.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BGSimpleListCell.reuseIdentifier, for: indexPath) as! BGSimpleListCell
        
        switch Currencies.list[indexPath.row] {
        case .eur:
            let title = "Euro (EUR)"
            cell.set(title)
        case .ron:
            let title = "Romanian Leu (RON)"
            cell.set(title)
        case .dollar:
            let title = "US Dollar (USD)"
            cell.set(title)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCurrency(Currencies.list[indexPath.row].rawValue.uppercased())
        dismiss(animated: true)
    }
}
