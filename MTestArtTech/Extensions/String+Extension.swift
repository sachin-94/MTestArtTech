//
//  String+Extension.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import Foundation

extension String {
    
    // Methods for validating form data using Regular Expressions
    
    func isValidEmail() -> Bool {
        // Reg Ex for matching email address
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        // First name containing only letters, spaces, hyphens, and apostrophes
        let regEx = "^[a-zA-Z'\\- ]+$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    func isValidGender() -> Bool {
        let regEx = "^(male|female|others)$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        // Password with at least 8 characters, containing at least one uppercase letter, one lowercase letter, one digit, and one special character
        let regEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    func isValidUsername() -> Bool {
        // Username containing only letters, numbers, underscores, hyphens, and periods
        let regEx = "^[a-zA-Z0-9_\\-\\.]+$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    func isValidMobileNumber() -> Bool {
        // Mobile number, assuming a 10-digit format without spaces, dashes, or country codes
        let regEx = "^\\d{10}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

}
