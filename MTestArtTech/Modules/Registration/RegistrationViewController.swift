//
//  RegistrationViewController.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
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
    
    @IBOutlet weak var nameInstructions: UILabel!
    
    @IBOutlet weak var confirmPasswordInstructions: UILabel!
    @IBOutlet weak var passwordInstructions: UILabel!
    @IBOutlet weak var userNameInstructions: UILabel!
    @IBOutlet weak var emailInstructions: UILabel!
    @IBOutlet weak var mobileInstructions: UILabel!
    @IBOutlet weak var lastNameInstructions: UILabel!
    
    @IBOutlet weak var genderInstructions: UILabel!
    @IBOutlet weak var passwordVisibility: UIButton!
    @IBOutlet weak var confirmPasswordVisibility: UIButton!
    var isFormValid = false
    var previousInstructionLabel: UILabel!
    
    private var binding = Set<AnyCancellable>()
    
    let viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        previousInstructionLabel = nameInstructions
        registerButton.layer.cornerRadius = 10
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
            if !(self?.passwordField.text?.isEmpty ?? true) {
                self?.confirmPasswordField.isUserInteractionEnabled = isValid
            }
        }.store(in: &binding)
        
        viewModel.isValidConfirmPassword.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.confirmPasswordValidationLbl.isHidden = isValid
        }.store(in: &binding)
        
        viewModel.isValidForm.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.isFormValid = isValid
            print("Form is \(self!.isFormValid)")
        }.store(in: &binding)
    }
    
    func configureTextFields() {
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        genderField.delegate = self
        mobileField.delegate = self
        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
            
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
            viewModel.passsword = textField.text ?? ""
        case 7:
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
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                
                // Action for UIAlert
                let action  = UIAlertAction(title: "Done", style: .default) { (action:UIAlertAction!) in
                    self.signInAction("")
                }
                
                self.presentAlertWithAction(WithTitle: "Success", message: "Registration success", actions: [action])
            } else {
                self.presentAlert(withTitle: "Attention", message: "Please enter valid information in the fields")
            }
        } else {
            self.presentAlert(withTitle: "Attention", message: "Please fill all the fields")
        }
    }
    @IBAction func signInAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    @IBAction func visibilityAction(_ sender: UIButton) {
        if sender.tag == 0 {
            if sender.image(for: .normal) == UIImage(named: "closed-eye") {
                sender.setImage(UIImage(named: "eye"), for: .normal)
                passwordField.isSecureTextEntry = true
            } else {
                sender.setImage(UIImage(named: "closed-eye"), for: .normal)
                passwordField.isSecureTextEntry = false
            }
        } else {
            if sender.image(for: .normal) == UIImage(named: "closed-eye") {
                sender.setImage(UIImage(named: "eye"), for: .normal)
                confirmPasswordField.isSecureTextEntry = true
            } else {
                sender.setImage(UIImage(named: "closed-eye"), for: .normal)
                confirmPasswordField.isSecureTextEntry = false
            }
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        previousInstructionLabel.isHidden = true
        switch textField.tag {
        case 0:
            previousInstructionLabel = nameInstructions
            nameInstructions.isHidden = false
        case 1:
            previousInstructionLabel = lastNameInstructions
            lastNameInstructions.isHidden = false
        case 2:
            previousInstructionLabel = genderInstructions
            genderInstructions.isHidden = false
        case 3:
            previousInstructionLabel = mobileInstructions
            mobileInstructions.isHidden = false
        case 4:
            previousInstructionLabel = emailInstructions
            emailInstructions.isHidden = false
            scrollToBottom()
        case 5:
            previousInstructionLabel = userNameInstructions
            userNameInstructions.isHidden = false
        case 6:
            previousInstructionLabel = passwordInstructions
            passwordInstructions.isHidden = false
            scrollToBottom()
        case 7:
            previousInstructionLabel = confirmPasswordInstructions
            confirmPasswordInstructions.isHidden = false
            scrollToBottom()
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameField.becomeFirstResponder()
        case 1:
            genderField.becomeFirstResponder()
        case 2:
            mobileField.becomeFirstResponder()
        case 3:
            emailField.becomeFirstResponder()
        case 4:
            usernameField.becomeFirstResponder()
        case 5:
            passwordField.becomeFirstResponder()
        case 6:
            if confirmPasswordField.isUserInteractionEnabled {
                confirmPasswordField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        case 7:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
}
