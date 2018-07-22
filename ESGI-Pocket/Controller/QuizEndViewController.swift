//
//  QuizEndViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 22/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class QuizEndViewController: UIViewController {

    var quiz: Quiz!
    var goodAnswersNumber: Int = 0
    
    @IBOutlet weak var quizNameLabel: UILabel!
    @IBOutlet weak var quizResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizNameLabel.text = self.quiz.name
        self.quizResultLabel.text = self.goodAnswersNumber.description + " bonnes réponses sur " + self.quiz.questions.count.description + " questions"
        uploadResult()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func uploadResult() {
        let quizProvider = QuizProvider()
        quizProvider.uploadQuizResult(result: self.goodAnswersNumber, idUser: CurrentUser.currentUser.id, idQuiz: self.quiz.id) { (response) in

        }
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    }
    
    @IBAction func retryQuizButtonPressed(_ sender: Any) {
        let quizPresentation = QuizPresentationViewController()
        quizPresentation.quiz = self.quiz
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(quizPresentation, animated: true)
    }
    
}
