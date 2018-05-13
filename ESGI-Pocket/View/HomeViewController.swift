//
//  HomeViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 09/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var jwt: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // read local storage
    // if there is credenitals try to login,
    // if there is not, or login failed, show login view controller
    func login() {

        // read local storage
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let loginDetails = json as? [String:String]
            else {

                // no file. Show login viewController
                return
        }
        
        print(loginDetails)
        
        // Try to login
        Login.login(email: loginDetails["email"]!, password: loginDetails["password"]!, callback: { response in
            //
        })
        
    }
    
}
