//
//  LoginViewController.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var screen: LoginScreen?
    private let viewModel: LoginViewModel = LoginViewModel()
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configProtocols()
        dismissKeyboard()
        validateTextFields()
    }
    
    private func configNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        screen?.configTextFieldDelegate(delegate: self)
        screen?.delegate(delegate: self)
        viewModel.delegate(delegate: self)
    }
    
    private func validateTextFields() {
        guard let email = screen?.emailTextField.text,
              let password = screen?.passwordTextField.text else { return }
        let isEnableLoginButton = viewModel.validateEmailAndPassword(email: email, password: password)
        screen?.isEnableLoginButton(isEnable: isEnableLoginButton)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            switch textField {
            case screen?.emailTextField:
                guard let email = screen?.emailTextField.text else { return }
                let isValid = viewModel.validateEmail(email: email)
                screen?.emailTextField.layer.borderWidth = isValid ? 0 : 1.0
                screen?.emailTextField.layer.borderColor = isValid ? UIColor.appBackground.cgColor : UIColor.red.cgColor
            case screen?.passwordTextField:
                guard let password = screen?.passwordTextField.text else { return }
                let isValid = viewModel.validatePassword(password: password)
                screen?.passwordTextField.layer.borderWidth = isValid ? 0 : 1.0
                screen?.passwordTextField.layer.borderColor = isValid ? UIColor.appBackground.cgColor : UIColor.red.cgColor
            default:
                break
            }
        }
        validateTextFields()
    }
}

extension LoginViewController: LoginScreenDelegate {
    func tappedRecoveryPasswordButton() {
        showAlert(title: "Atenção", message: "A funcionalidade de recuperar senha será implementada em breve.")
    }
    
    func tappedLoginButton() {
        guard let email = screen?.emailTextField.text,
              let password = screen?.passwordTextField.text else { return }
        viewModel.signInWithEmailAndPassword(email: email, password: password)
    }
    
    func tappedRegisterButton() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginSuccess() {
        screen?.clearTextFields()
        showAlert(title: "Sucesso", message: "Login efetuado com sucesso!")
    }
    
    func loginFailure(error: String) {
        showAlert(title: "Atenção", message: error)
    }
}
