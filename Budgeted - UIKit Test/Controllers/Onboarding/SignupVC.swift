//
//  SignupVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

class SignupVC: BGOnboardingDataLoadingVC {
    
    //MARK: - Properties
    
    private var stackView: UIStackView!
    
    private let logoImageView               = UIImageView()
    private let fullnameTextField           = BGTextField(placeholder: "Full Name")
    private let emailTextField              = BGTextField(placeholder: "Email", isEmail: true)
    private let passwordTextField           = BGTextField(placeholder: "Password", isSecureTextEntry: true)
    private let confirmPasswordField        = BGTextField(placeholder: "Confirm Password", isSecureTextEntry: true, isLast: true)
    private let signupButton                = BGPrimaryButton(title: "Sign up", type: .main)
    private let alreadyHaveAccountButton    = UIButton()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        createKeyboardDismissTapGestureRecognizer()
    }
    
    //MARK: - Actions
    
    @objc private func didTapSignupButton() {
        
        // Values
        
        guard let fullname                  = fullnameTextField.text?.capitalized else { return }
        guard let email                     = emailTextField.text?.lowercased() else { return }
        guard let password                  = passwordTextField.text else { return }
        guard let repeatPassword            = confirmPasswordField.text else { return }
        
        // Conditions
        
        let areTextFieldsNotEmpty: Bool     = !fullname.isEmpty && !email.isEmpty && !password.isEmpty && !repeatPassword.isEmpty && password == repeatPassword
        let isAnyTextFieldEmpty: Bool       = fullname.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty
        let arePasswordsNotMatching: Bool   = password != repeatPassword
        
        if areTextFieldsNotEmpty {
            presentBGOnboardingLoadinViewOnMainThread()
            view.endEditing(true)
            
            let credentials = AuthCredentials(email: email, password: password, fullname: fullname)
            
            APIManager.registerUser(withCredentials: credentials) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    self.dismissBGOnboardingLoadingViewOnMainThread()
                    self.presentFirebaseRegistrationErrorAlertOnMainThread(with: error)
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismissBGOnboardingLoadingViewOnMainThread()
                    self.changeAppRootViewControllerToHomeVCOnMainThread()
                }
                
                return
            }
            
        } else if isAnyTextFieldEmpty {
            presentLocalRegistrationFieldsValidationAlertOnMainThread(of: .emptyField)
            return
        } else if arePasswordsNotMatching {
            presentLocalRegistrationFieldsValidationAlertOnMainThread(of: .passwordsNotMatching)
            return
        }
    }
    
    @objc private func didTapAlreadyHaveAccount() {
        
        //  Check if the current view controller is the root view controller of the navigation controller
        
        let isRootViewController = navigationController?.viewControllers.count == 1
        
        // If it is true, push the loginVC on the stack, otherwise the loginVC is the root view controller and the current view controller needs to be popped
        
        if isRootViewController {
            navigationController?.pushViewController(LoginVC(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapBackgroundToDismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func presentFirebaseRegistrationErrorAlertOnMainThread(with error: Error) {
        DispatchQueue.main.async {
            let title = "Failed to register"
            let alert = self.createAlert(withTitle: title, message: error.localizedDescription)
            self.present(alert, animated: true)
        }
    }
    
    private func presentLocalRegistrationFieldsValidationAlertOnMainThread(of type: BGValidationAlertType) {
        DispatchQueue.main.async {
            let title = "Failed to register"
            let alert = self.createAlert(withTitle: title, message: type.rawValue)
            self.present(alert, animated: true)
        }
    }
    
    private func changeAppRootViewControllerToHomeVCOnMainThread() {
        DispatchQueue.main.async {
            let homeVC = HomeVC()
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    private func createKeyboardDismissTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundToDismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - UI Configuration
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureUI() {
        configureLogoImageView()
        configureStackView()
        configureTextFields()
        configureSignupButton()
        configureAlreadyHaveAccountButton()
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.layer.cornerRadius    = 8
        logoImageView.clipsToBounds         = true
        logoImageView.backgroundColor       = .secondarySystemBackground
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureStackView() {
        stackView           = UIStackView(arrangedSubviews: [fullnameTextField, emailTextField, passwordTextField, confirmPasswordField])
        view.addSubview(stackView)
        stackView.axis      = .vertical
        stackView.spacing   = 20
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
    
    private func configureTextFields() {
        fullnameTextField.delegate      = self
        emailTextField.delegate         = self
        passwordTextField.delegate      = self
        confirmPasswordField.delegate   = self
    }
    
    private func configureSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signupButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.setTitle("Already have an account? Log in", for: .normal)
        alreadyHaveAccountButton.setTitleColor(.primaryColor, for: .normal)
        alreadyHaveAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        alreadyHaveAccountButton.titleLabel?.minimumScaleFactor = 0.8
        
        alreadyHaveAccountButton.addTarget(self, action: #selector(didTapAlreadyHaveAccount), for: .touchUpInside)
        
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            alreadyHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            alreadyHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

}

//MARK: - UITextFieldDelegate

extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullnameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordField.becomeFirstResponder()
        case confirmPasswordField:
            confirmPasswordField.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        
        return true
    }
}
