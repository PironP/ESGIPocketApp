//
//  QuizQuestionViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 10/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class QuizQuestionViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var responseListView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func leaveButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        // Affiche fin du quiz
        // navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
}
