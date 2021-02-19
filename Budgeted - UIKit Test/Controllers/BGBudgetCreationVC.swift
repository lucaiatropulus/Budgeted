//
//  BGBudgetCreationVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 16.02.2021.
//

import UIKit
import Firebase

protocol BGBudgetCreationVCDelegate: class {
    func didCreateNewBudget(budget: Budget)
}

class BGBudgetCreationVC: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: BGBudgetCreationVCDelegate?
    
    #warning("Change back to UITableViewController and BGFormCells when you resolve the reloadData weird behaviour")
    
    private var stackView: UIStackView!
    private let budgetRow                   = BGFormRow()
    private let amountRow                   = BGFormRow()
    private let currencyRow                 = BGFormRow()
    private let recurrenceRow               = BGFormRow()
    private let actionButton                = BGPrimaryButton(title: "Create Budget", type: .main)
    
    private var budgetName: String          = ""
    private var budgetAmount: Double        = 0.0
    private var budgetCurrency: String      = Currencies.list[0].rawValue.uppercased()
    private var budgetReccurence: String    = Recurrences.list[0].rawValue
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        addDimissKeyboardTapGestureRecognizer()
    }
    
    //MARK: - Actions
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func didTapBackgroundToDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapSelectCurrencyRow() {
        view.endEditing(true)
        let modal                       = CurrencySelectionModal()
        modal.delegate                  = self
        modal.modalPresentationStyle    = .custom
        modal.transitioningDelegate     = self
        self.present(modal, animated: true)
    }
    
    @objc private func didTapSelectReccuranceRow() {
        view.endEditing(true)
        let modal                       = RecurrenceSelectionModal()
        modal.delegate                  = self
        modal.modalPresentationStyle    = .custom
        modal.transitioningDelegate     = self
        self.present(modal, animated: true)
    }
    
    @objc private func didTapActionButton() {
        view.endEditing(true)
        if budgetName.isEmpty {
            //present alert and return
        }
        guard let id            = Auth.auth().currentUser?.uid else { return }
        let creationDate        = Date()
        var oneMonth            = DateComponents()
        oneMonth.month          = 1
        guard let resetDate     = Calendar.current.date(byAdding: oneMonth, to: creationDate) else { return }
        let spentAmount: Double = 0.0
        
        
        
        let budget              = Budget(userID: id,
                                         name: budgetName,
                                         resetDate: resetDate,
                                         currencyType: budgetCurrency,
                                         recurrance: budgetReccurence,
                                         budgetedAmount: budgetAmount,
                                         spentAmount: spentAmount)
        delegate?.didCreateNewBudget(budget: budget)
        dismiss(animated: true)
    }
    
    //MARK: - Helpers
    
    private func addDimissKeyboardTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundToDismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - UI Configuration
    
    private func configureVC() {
        view.backgroundColor                = .systemBackground
        let cancelButton                    = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissVC))
        cancelButton.tintColor              = .label
        navigationItem.rightBarButtonItem   = cancelButton
    }
    
    private func configureUI() {
        configureStackView()
        configureRows()
        configureActionButton()
    }
    
    private func configureStackView() {
        stackView               = UIStackView(arrangedSubviews: [budgetRow, amountRow, currencyRow, recurrenceRow])
        stackView.axis          = .vertical
        stackView.distribution  = .fillEqually
        stackView.spacing       = 0
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func configureRows() {
        budgetRow.configurePlainRow(withTitle: BGFormRowTitles.name, imageName: Icons.budget, placeholder: BGFormRowPlaceholders.name)
        amountRow.configurePlainRow(withTitle: BGFormRowTitles.amount, imageName: Icons.amount, placeholder: BGFormRowPlaceholders.amount, isNumberField: true)
        currencyRow.configureOptionRow(withTitle: BGFormRowTitles.currency, imageName: Icons.currency, currency: budgetCurrency)
        recurrenceRow.configureOptionRow(withTitle: BGFormRowTitles.recurrence, imageName: Icons.calendar, reccurence: budgetReccurence)
        
        let currencyTap = UITapGestureRecognizer(target: self, action: #selector(didTapSelectCurrencyRow))
        currencyRow.addGestureRecognizer(currencyTap)
        
        let recurrenceTap = UITapGestureRecognizer(target: self, action: #selector(didTapSelectReccuranceRow))
        recurrenceRow.addGestureRecognizer(recurrenceTap)
        
        budgetRow.delegate      = self
        amountRow.delegate      = self
        currencyRow.delegate    = self
        recurrenceRow.delegate  = self
    }
    
    private func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

//MARK: - UIViewControllerTransitionDelegate

extension BGBudgetCreationVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BGModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

//MARK: - BGFormCellDelegate

extension BGBudgetCreationVC: BGFormRowDelegate {
    func didSetValueFor(sender: BGFormRow, value: String) {
        
        switch sender {
        case budgetRow:
            budgetName          = value
            print(budgetName)
        case amountRow:
            budgetAmount        = Double(value) ?? 0.0
            print(budgetAmount)
        case currencyRow:
            budgetCurrency      = value
            print(budgetCurrency)
        case recurrenceRow:
            budgetReccurence    = value
            print(budgetReccurence)
        default:
            break
        }
    }
}

//MARK: - CurrencySelectionModalDelegate

extension BGBudgetCreationVC: CurrencySelectionModalDelegate {
    func didSelectCurrency(_ currency: String) {
        budgetCurrency = currency
        currencyRow.update(withCurrency: budgetCurrency)
    }
}

//MARK: RecurrenceSelectionModalDelegate

extension BGBudgetCreationVC: RecurrenceSelectionModalDelegate {
    func didSelectRecurrence(_ recurrence: String) {
        budgetReccurence = recurrence
        recurrenceRow.update(withRecurrance: budgetReccurence)
    }
}
