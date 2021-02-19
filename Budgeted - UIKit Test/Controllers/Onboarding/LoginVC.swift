//
//  LoginVC.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import UIKit

class LoginVC: BGOnboardingDataLoadingVC {
    
    //MARK: - Properties
    
    private let logoImageView           = UIImageView()
    private let emailTextField          = BGTextField(placeholder: "Email", isEmail: true)
    private let passwordTextField       = BGTextField(placeholder: "Password", isSecureTextEntry: true, isLast: true)
    private let forgotPasswordButton    = UIButton()
    private let loginButton             = BGPrimaryButton(title: "Log in", type: .main)
    private let dontHaveAccountButton   = UIButton()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        createKeyboardDismissTapGestureRecognizer()
    }
    
    //MARK: - Actions
    
    @objc private func didTapForgotPasswordButton() {
        
    }
    
    @objc private func didTapLoginButton() {
        
        // Values
        
        guard let email                 = emailTextField.text?.lowercased() else { return }
        guard let password              = passwordTextField.text else { return }
        
        // Conditions
        
        let areTextFieldsNotEmpty: Bool = !email.isEmpty && !password.isEmpty
        let isAnyTextFieldEmpty: Bool   = email.isEmpty || password.isEmpty
        
        if areTextFieldsNotEmpty {
            presentBGOnboardingLoadinViewOnMainThread()
            view.endEditing(true)
            APIManager.loginUser(withEmail: email, password: password) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    self.dismissBGOnboardingLoadingViewOnMainThread()
                    self.presentFirebaseRegistrationErrorAlertOnMainThread(with: error)
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.dismissBGOnboardingLoadingViewOnMainThread()
                    self.changeAppRootViewControllerToHomeVCOnMainThread()
                }
                
                return
            }
        } else if isAnyTextFieldEmpty {
            presentLocalRegistrationFieldsValidationAlertOnMainThread(of: .emptyField)
            return
        }
    }
    
    @objc private func didTapDontHaveAccountButton() {
        
        //  Check if the current view controller is the root view controller of the navigation controller
        
        let isRootViewController = navigationController?.viewControllers.count == 1
        
        // If it is true, push the signupVC on the stack, otherwise the signupVC is the root view controller and the current view controller needs to be popped
        
        if isRootViewController {
            navigationController?.pushViewController(SignupVC(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapBackgroundToDismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Helpers
    
    private func presentFirebaseRegistrationErrorAlertOnMainThread(with error: Error) {
        DispatchQueue.main.async {
            let title = "Failed to login"
            let alert = self.createAlert(withTitle: title, message: error.localizedDescription)
            self.present(alert, animated: true)
        }
    }
    
    private func presentLocalRegistrationFieldsValidationAlertOnMainThread(of type: BGValidationAlertType) {
        DispatchQueue.main.async {
            let title = "Failed to login"
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
        configureEmailTextField()
        configurePasswordTextField()
        configureForgotPasswordButton()
        configureLoginButton()
        configureDontHaveAccountButton()
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
    
    private func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    private func configureForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
        forgotPasswordButton.setTitleColor(.primaryColor, for: .normal)
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 28),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func configureDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.setTitle("Don't have an account? Sign up", for: .normal)
        dontHaveAccountButton.setTitleColor(.primaryColor, for: .normal)
        dontHaveAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dontHaveAccountButton.titleLabel?.minimumScaleFactor = 0.8
        
        dontHaveAccountButton.addTarget(self, action: #selector(didTapDontHaveAccountButton), for: .touchUpInside)
        
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dontHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }

}

//MARK: - UITextFieldDelegate

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        
        return true
    }
}
