//
//  LoginViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 08/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        // Call async func to log in
        let loginModel = Login()
        loginModel.login(email: email, password: password, callback: { response in
            
            // execute the code in the main thread
            DispatchQueue.main.async(execute: {
                if response.statusCode == 200 {
  
                    self.saveLoginDetailsToLocalStorage(email: email, password: password)
                    self.navigationController?.popViewController(animated: true)

                }
                else {
                    if (response.error == "activation_required") {
                        CurrentUser.currentUser.email = email
                        let confirmEmailView = ConfirmEmailViewController()
                        self.navigationController?.pushViewController(confirmEmailView, animated: true)
                    }
                    else {
                        self.loginErrorLabel.isHidden = false
                    }
                }
            })
        })
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    
    // If login successed, store login information in local storage
    func saveLoginDetailsToLocalStorage(email: String, password: String) {
        
        var dict = Dictionary<String, Any>()
        dict = ["email" :email, "password" :password]
        
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0)) else {
            return
        }
        
        do {
            try data.write(to: filePath)
        } catch {
        }
        

    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

