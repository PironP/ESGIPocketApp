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
        
        // Call async func to log in
        Login.login(username: emailTextField.text!, password: passwordTextField.text!, callback: { response in
            
            // execute the code in the main thread
            DispatchQueue.main.async(execute: {
                if response != "" {
                    // response is the JWT
                    print(response)
                    let homeViewController = HomeViewController()
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
    
}
