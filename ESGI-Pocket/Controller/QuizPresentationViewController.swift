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
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicNameLabel.text = quiz.topic.name
        quizNameLabel.text = quiz.name
        authorNameLabel.text = quiz.author.firstname + " " + quiz.author.lastname
        
        getQuiz()
    }
    
    func getQuiz() {
        let quizProvider = QuizProvider()
        quizProvider.getQuestions(quiz: self.quiz) { questionList in
            if questionList.count > 0 {
                self.quiz.questions = questionList
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeQuizButtonPressed(_ sender: Any) {
        if self.quiz.questions.count == 0 {
            self.getQuiz()
            return
        }
        let quizQuestionViewController = QuizQuestionViewController()
        quizQuestionViewController.quiz = self.quiz
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(quizQuestionViewController, animated: true)
    }
}
