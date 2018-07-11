//
//  QuizPresentationViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 09/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class QuizPresentationViewController: UIViewController {

    var quiz: Quiz!
    
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicNameLabel.text = quiz.topic.name
        quizNameLabel.text = quiz.name
        
        // Get stats for this quiz
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeQuizButtonPressed(_ sender: Any) {
        
    }
}
