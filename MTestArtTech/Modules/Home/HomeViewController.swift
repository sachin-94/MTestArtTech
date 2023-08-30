//
//  HomeViewController.swift
//  MTestArtTech
//
//  Created by Sachin George on 30/08/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var signoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signoutButton.layer.cornerRadius = 10
    }
    
    @IBAction func signoutAction(_ sender: Any) {
        let removeAction = UIAlertAction(title: "No", style: .destructive) { action in
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            self.setRootVC()
        }
        
        let keepAction = UIAlertAction(title: "Yes", style: .default) { action in
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            self.setRootVC()
        }
        self.presentAlertWithAction(WithTitle: "Sign out", message: "Do you want to keep the user data?", actions: [keepAction,removeAction])
    }
    
    func setRootVC() {
        let vc = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }

}
