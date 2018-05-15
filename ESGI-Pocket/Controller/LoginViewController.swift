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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        // Call async func to log in
        Login.login(email: email, password: password, callback: { response in
            
            // execute the code in the main thread
            DispatchQueue.main.async(execute: {
                if response != "" {
                    // response is the JWT
                    
                    self.saveLoginDetailsToLocalStorage(email: email, password: password)
                    let homeViewController = HomeViewController()
                    self.dismiss(animated: true, completion: nil)
                    self.present(homeViewController, animated: true, completion: nil)
                    
                }
                else {
                    self.loginErrorLabel.isHidden = false
                }
            })
        })
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
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
