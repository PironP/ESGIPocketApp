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

    @IBAction func lessonsButtonPressed(_ sender: Any) {
        let lessonsListView = LessonsListViewController()
        self.present(lessonsListView, animated: true, completion: nil)
    }
    
    @IBAction func discussionsButtonPressed(_ sender: Any) {
        let discussionsListView = DiscussionsListViewController()
        self.present(discussionsListView, animated: true, completion: nil)
    }
    
    @IBAction func messagesButtonPressed(_ sender: Any) {
        let messagesListView = MessagesListViewController()
        self.present(messagesListView, animated: true, completion: nil)
    }
    
    @IBAction func quizButtonPressed(_ sender: Any) {
        let quizListView = QuizListViewController()
        self.present(quizListView, animated: true, completion: nil)
    }
    
    @IBAction func planningButtonPressed(_ sender: Any) {
        let planningView = PlanningViewController()
        self.present(planningView, animated: true, completion: nil)
    }
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        // delete local storage
        let loginView = LoginViewController()
        self.dismiss(animated: true, completion: nil)
        self.present(loginView, animated: true, completion: nil)
    }
}
