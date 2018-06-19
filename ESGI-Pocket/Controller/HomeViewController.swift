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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func navigationButtonPressed(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            let  topicView = TopicViewController()
            topicView.fileTypeRequestd = 1
            self.present(topicView, animated: true, completion: nil)
            
        case 1:
            let  topicView = TopicViewController()
            topicView.fileTypeRequestd = 2
            self.present(topicView, animated: true, completion: nil)
        case 3:
            let discussionsListView = DiscussionsListViewController()
            self.present(discussionsListView, animated: true, completion: nil)
        case 4:
            let planningView = PlanningViewController()
            self.present(planningView, animated: true, completion: nil)
        default:
            return
        }
    }
    
    @IBAction func navigationButton(_ sender: Any) {
    }
    
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        
        
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        print(basePath)
        
        let dict = ["email" :"", "password" :""]
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0)) else {
            return
        }
        do {
            try data.write(to: filePath)
        } catch {
            
        }
        
        CurrentUser.currentUser.jwt = ""
        
        let loginView = LoginViewController()
        self.dismiss(animated: true, completion: nil)
        //self.present(loginView, animated: true, completion: nil)
    }
}
