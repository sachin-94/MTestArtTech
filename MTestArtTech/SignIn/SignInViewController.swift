//
//  SignInViewController.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import UIKit
import Combine

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameValidationLbl: UILabel!
    @IBOutlet weak var passwordValidationLbl: UILabel!
    
    @IBOutlet weak var signinButton: UIButton!
    
    var binding = Set<AnyCancellable>()
    
    var isFormValid = false
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextFields()
        setupBinding()
    }
    
    func setupBinding() {
        
        // Username validation event observer
        viewModel.isValidUsername.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.usernameValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Password validation event observer
        viewModel.isValidPassword.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.passwordValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        viewModel.isValidForm.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.isFormValid = isValid
            print("Form is \(self!.isFormValid)")
        }.store(in: &binding)
    }
    
    func configureTextFields() {
        usernameField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
    }
    
    @objc func textFieldTextChanged(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            viewModel.username = textField.text ?? ""
        case 1:
            viewModel.password = textField.text ?? ""
        default:
            return
        }
    }
    
    @IBAction func signinAction(_ sender: Any) {
    }
    @IBAction func registerAction(_ sender: Any) {
    }
    
}
