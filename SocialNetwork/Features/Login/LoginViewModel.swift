//
//  LoginViewModel.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelDelegate: AnyObject {
    func loginSuccess()
    func loginFailure(error: String)
}

final class LoginViewModel {
    
    private weak var delegate: LoginViewModelDelegate?
    
    func delegate(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    private let auth = Auth.auth()
    
    func signInWithEmailAndPassword(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    self?.delegate?.loginSuccess()
                } else {
                    self?.delegate?.loginFailure(error: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func validateEmailAndPassword(email: String, password: String) -> Bool {
        if (email.isValid(validType: .email) && password.isValid(validType: .password)) {
            return true
        } else {
            return false
        }
    }
    
    func validateEmail(email: String) -> Bool {
        return email.isValid(validType: .email)
    }
    
    func validatePassword(password: String) -> Bool {
        return password.isValid(validType: .password)
    }
}
