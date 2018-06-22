//
//  SplashScreenViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        login()
    }
    
    // read local storage
    // if there is credenitals try to login,
    // if there is not, or login failed, show login view controller
    func login() {
  
        if CurrentUser.currentUser.jwt != "" {
            // User already loged in
            let homeView = HomeViewController()
            self.present(homeView, animated: true, completion: nil)
            return
        }
        
        // read local storage
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        print(basePath)
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let loginDetails = json as? [String:String] else {
            
                let loginView = LoginViewController()
                self.present(loginView, animated: true, completion: nil)

                return
        }
        
        // Try to login
        let loginModel = Login()
        loginModel.login(email: loginDetails["email"]!, password: loginDetails["password"]!, callback: { response in
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    let currentUser = CurrentUser.currentUser

                    currentUser.email = loginDetails["email"]!
                    let homeView = HomeViewController()
                    self.present(homeView, animated: true, completion: nil)
                }
            }
            else {
                
                let loginView = LoginViewController()
                self.present(loginView, animated: true, completion: nil)
            }
        })
        
    }

}
