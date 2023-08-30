//
//  RegistrationViewController.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

