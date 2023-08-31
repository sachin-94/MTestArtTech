//
//  RegistrationViewModel.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import Combine

class RegistrationViewModel {
    
    // Published variables for validating the entered texts inside the textfields
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: String = ""
    @Published var mobileNumber: String = ""
    @Published var passsword: String = ""
    @Published var confirmPassword: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    
    lazy var isValidFirstName = $firstName.map { $0.isEmpty || $0.isValidName() }
    lazy var isValidLastName = $lastName.map { $0.isEmpty || $0.isValidName() }
    lazy var isValidGender = $gender.map { $0.isEmpty || $0.isValidGender() }
    lazy var isValidMobileNumber = $mobileNumber.map { $0.isEmpty || $0.isValidMobileNumber() }
    lazy var isValidUsername = $username.map { $0.isEmpty || $0.isValidUsername() }
    lazy var isValidPassword = $passsword.map { $0.isEmpty || $0.isValidPassword() }
    lazy var isValidConfirmPassword = $confirmPassword.map { [weak self] in $0.isEmpty || $0 == self?.passsword }
    lazy var isPasswordsMatch = Publishers.CombineLatest($passsword, $confirmPassword).map { $0 == $1 }.eraseToAnyPublisher()
    lazy var isValidEmail = $email.map { $0.isEmpty || $0.isValidEmail() }
    
    // Checks if all the fields are valid and updates everytime a field value changes. If any field becomes invalid, the condition fails and returns false
    lazy var isValidForm = Publishers.MergeMany([isValidFirstName,isValidLastName,isValidGender,isValidMobileNumber,isValidUsername,isValidPassword,isValidConfirmPassword,isValidEmail]).map { $0 == true }
}
