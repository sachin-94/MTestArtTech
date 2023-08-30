//
//  RegistrationViewController.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var firstNameValidationLbl: UILabel!
    @IBOutlet weak var lastNameValidationLbl: UILabel!
    @IBOutlet weak var genderValidationLbl: UILabel!
    @IBOutlet weak var mobileNoValidationLbl: UILabel!
    @IBOutlet weak var emailValidationLbl: UILabel!
    @IBOutlet weak var usernameValidationLbl: UILabel!
    @IBOutlet weak var passwordValidationLbl: UILabel!
    @IBOutlet weak var confirmPasswordValidationLbl: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var isFormValid = false
    
    var activeFieldTag = 0
    
    private var binding = Set<AnyCancellable>()
    
    let viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTextFields()
        setupBinding()
    }
    
    func setupBinding() {
        // Email validation event observer
        viewModel.isValidEmail.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.emailValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Name validations event observer
        viewModel.isValidFirstName.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.firstNameValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        viewModel.isValidLastName.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.lastNameValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Gender validation event observer
        viewModel.isValidGender.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.genderValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Mobile validation event observer
        viewModel.isValidMobileNumber.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.mobileNoValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Username validation event observer
        viewModel.isValidUsername.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.usernameValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Passwords validation event observer
        viewModel.isValidPassword.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.passwordValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        viewModel.isValidConfirmPassword.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.confirmPasswordValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        // Validation for passwords matching
//        viewModel.isPasswordsMatch.receive(on: DispatchQueue.main).sink { [weak self] isValid in
//            if self?.activeFieldTag == self?.passwordField.tag {
//                self?.passwordValidationLbl.isHidden = isValid
//            } else if self?.activeFieldTag == self?.confirmPasswordField.tag {
//                self?.confirmPasswordValidationLbl.isHidden = isValid
//            }
//        }.store(in: &binding)
        
        viewModel.isValidForm.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.isFormValid = isValid
            print("Form is \(self!.isFormValid)")
        }.store(in: &binding)
    }
    
    func configureTextFields() {
        
        firstNameField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        genderField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        mobileField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        usernameField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(textFieldTextChanged(_ :)), for: .editingChanged)
    }
    
    @objc func textFieldTextChanged(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            viewModel.firstName = textField.text ?? ""
        case 1:
            viewModel.lastName = textField.text ?? ""
        case 2:
            viewModel.gender = textField.text ?? ""
        case 3:
            viewModel.mobileNumber = textField.text ?? ""
        case 4:
            viewModel.email = textField.text ?? ""
        case 5:
            viewModel.username = textField.text ?? ""
        case 6:
            activeFieldTag = textField.tag
            viewModel.passsword = textField.text ?? ""
        case 7:
            activeFieldTag = textField.tag
            viewModel.confirmPassword = textField.text ?? ""
        default:
            return
        }
    }

    @IBAction func registerAction(_ sender: Any) {
        guard let firstName = firstNameField.text else { return }
        guard let lastName = lastNameField.text else { return }
        guard let gender = genderField.text else { return }
        guard let mobileNumber = mobileField.text else { return }
        guard let email = emailField.text else { return }
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        guard let confirmPassword = confirmPasswordField.text else { return }
        
        let isAllFilled = [firstName,lastName,gender,mobileNumber,email,username,password,confirmPassword].filter { $0.isEmpty }.isEmpty
        if isAllFilled {
            if isFormValid {
                print("Form is valid")
            } else {
                print("Form is invalid")
            }
        } else {
            print("Form is invalid")
        }
    }
    @IBAction func signInAction(_ sender: Any) {
    }
    
}

