//
//  String + Extension.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 15/09/26.
//

import Foundation

enum ValidType {
    case email
    case password
}

extension String {
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = ".{6,}"
    }
    
    func isValid(validType: ValidType) -> Bool {
        let formart = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: formart, regex).evaluate(with: self)
    }
}
