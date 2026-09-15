//
//  RegisterViewModel.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import Foundation
import FirebaseAuth

protocol RegisterViewModelDelegate: AnyObject {
    func registerSuccess()
    func registerFailure(error: String)
}

final class RegisterViewModel {
    
    private weak var delegate: RegisterViewModelDelegate?
    
    func delegate(delegate: RegisterViewModelDelegate) {
        self.delegate = delegate
    }
    
    private let auth = Auth.auth()
    
    func createUserWithEmailAndPassword(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    self?.delegate?.registerSuccess()
                } else {
                    self?.delegate?.registerFailure(error: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func validateEmailPasswordAndConfirmPassword(email: String, password: String, confirmPassword: String) -> Bool {
        if (email.isValid(validType: .email) && password.isValid(validType: .password) && validateConfirmPassword(password: password, confirmPassword: confirmPassword)) {
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
    
    func validateConfirmPassword(password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
}
