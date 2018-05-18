//
//  SignUpViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 08/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var missingFieldsErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {

        // Check all fields then create account
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let password2 = retypePasswordTextField.text
            else {
                return
        }
        
        if firstName.count < 3 || lastName.count < 3 || email.count < 10 || password.count < 6 || password2.count < 6 {
            self.missingFieldsErrorLabel.isHidden = false
            return
        }
        if email.lowercased().range(of: "@myges.fr") == nil {
            self.emailErrorLabel.isHidden = false
            return
        }
        
        if password != password2 {
            self.passwordErrorLabel.isHidden = false
            return
        }
        
        let loginModel = Login()
        loginModel.signin(email: email, password: password, firstname: firstName, lastName: lastName, callback: { response in
            if response {
                let selectClassViewController = SelectClassViewController()
                self.present(selectClassViewController, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    
    @IBAction func backToLoginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
