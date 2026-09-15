//
//  RegisterViewController.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import UIKit

class RegisterViewController: UIViewController {

    private var screen: RegisterScreen?
    private let viewModel: RegisterViewModel = RegisterViewModel()
    
    override func loadView() {
        screen = RegisterScreen()
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
              let password = screen?.passwordTextField.text,
              let confirmPassword = screen?.confirmPasswordTextField.text else { return }
        let isEnableRegisterButton = viewModel.validateEmailPasswordAndConfirmPassword(email: email, password: password, confirmPassword: confirmPassword)
        screen?.isEnableRegisterButton(isEnable: isEnableRegisterButton)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
            case screen?.passwordTextField, screen?.confirmPasswordTextField:
                guard let password = screen?.passwordTextField.text,
                      let confirmPassword = screen?.confirmPasswordTextField.text else { return }
                var isValid = false
                if screen?.confirmPasswordTextField.text?.isEmpty ?? false {
                    isValid = viewModel.validatePassword(password: password)
                } else {
                    isValid = viewModel.validatePassword(password: password) && viewModel.validateConfirmPassword(password: password, confirmPassword: confirmPassword)
                }
                screen?.passwordTextField.layer.borderWidth = isValid ? 0 : 1.0
                screen?.passwordTextField.layer.borderColor = isValid ? UIColor.appBackground.cgColor : UIColor.red.cgColor
                screen?.confirmPasswordTextField.layer.borderWidth = isValid ? 0 : 1.0
                screen?.confirmPasswordTextField.layer.borderColor = isValid ? UIColor.appBackground.cgColor : UIColor.red.cgColor
            default:
                break
            }
        }
        validateTextFields()
    }
}

extension RegisterViewController: RegisterScreenDelegate {
    func tappedRegisterButton() {
        guard let email = screen?.emailTextField.text,
              let password = screen?.passwordTextField.text else { return }
        viewModel.createUserWithEmailAndPassword(email: email, password: password)
    }
    
    func tappedLoginButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func registerSuccess() {
        screen?.clearTextFields()
        showAlert(title: "Sucesso", message: "Registro efetuado com sucesso!") { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func registerFailure(error: String) {
        showAlert(title: "Atenção", message: error)
    }
}
