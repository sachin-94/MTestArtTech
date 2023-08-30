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
    var isValidCredentials = false
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signinButton.layer.cornerRadius = 10
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
        }.store(in: &binding)
        
        viewModel.isValidCredentials.receive(on: DispatchQueue.main).sink { [weak self] isValid in
            self?.isValidCredentials = isValid
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
        
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
        let isAllFilled = [username,password].filter { $0.isEmpty }.isEmpty
        if isAllFilled {
            if isFormValid {
                if isValidCredentials {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.setViewControllers([vc], animated: true)
                } else {
                    self.presentAlert(withTitle: "Invalid credentials", message: "Please check your credentials and try again")
                }
            } else {
                self.presentAlert(withTitle: "Attention", message: "Please enter valid information in the fields")
            }
        } else {
            self.presentAlert(withTitle: "Attention", message: "Please fill all the fields")
        }
    }
    @IBAction func registerAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
