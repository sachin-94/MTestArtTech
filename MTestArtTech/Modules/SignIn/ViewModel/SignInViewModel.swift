//
//  SignInViewModel.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import Combine
import Foundation

class SignInViewModel {
    
    // Published variables for validating the entered texts inside the textfields
    
    @Published var password: String = ""
    @Published var username: String = ""
    
    lazy var isValidUsername = $username.map { $0.isEmpty || $0.isValidUsername() }
    lazy var isValidPassword = $password.map { $0.isEmpty || $0.isValidPassword() }
    
    lazy var isValidForm = Publishers.MergeMany([isValidUsername,isValidPassword]).map { $0 == true }
    
    let storedUsername = UserDefaults.standard.string(forKey: "username")
    let storedPassword = UserDefaults.standard.string(forKey: "password")
    
    lazy var isValidCredentials = Publishers.CombineLatest($username, $password).map { [weak self] in $0 == self?.storedUsername && $1 == self?.storedPassword }.eraseToAnyPublisher()

}
