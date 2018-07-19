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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            redirectAfterLogin()
            return
        }
        
        // read local storage
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let loginDetails = json as? [String:String] else {
            
                let loginView = LoginViewController()
                navigationController?.pushViewController(loginView, animated: true)

                return
        }
        
        // Try to login
        let loginModel = Login()
        loginModel.login(email: loginDetails["email"]!, password: loginDetails["password"]!, callback: { response in
            if response.statusCode == 200 {
                DispatchQueue.main.async {

                    self.redirectAfterLogin()
                }
            }
            else {
                let loginView = LoginViewController()
                self.navigationController?.pushViewController(loginView, animated: true)
            }
        })
        
    }
    
    func redirectAfterLogin() {
        
        if CurrentUser.currentUser.role == 3 {
            let messageListView = MessagesListViewController()
            navigationController?.pushViewController(messageListView, animated: true)
            return
        }

        if CurrentUser.currentUser.classe != nil {
            let homeView = HomeViewController()
            navigationController?.pushViewController(homeView, animated: true)
            return
        }
        else {
            let selectClassView = SelectClassViewController()
            navigationController?.pushViewController(selectClassView, animated: true)
        }
    }

}
