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
    @IBOutlet weak var quizQuestionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var responseListView: UITableView!
    var questionIndex: Int = 0
    var quiz: Quiz!
    var currentQuestion: Question!
    var goodAnswerNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.responseListView.dataSource = self
        self.responseListView.delegate = self
        self.responseListView.isHidden = true
        self.responseListView.separatorStyle = .none
        self.quizQuestionView.layer.cornerRadius = 10
        
        currentQuestion = quiz.questions[0]
        loadQuestionsAnswers()
        
    }
    
    
    func loadQuestionsAnswers() {
        let quizProvider = QuizProvider()
        quizProvider.getAnswers(question: currentQuestion) { (answers) in
            if answers.count == 0 {
                // skip question
                return
            }
            self.questionLabel.text = self.currentQuestion.content
            self.currentQuestion.answers = answers
            self.questionNumberLabel.text = "question " + (self.questionIndex + 1).description + " sur " + self.quiz.questions.count.description
            self.responseListView.reloadData()
            self.responseListView.isHidden = false
        }
    }
    
    func answerChoosen(isGoodAnswer: Bool) {
        if isGoodAnswer {
            self.goodAnswerNumber += 1
        }
        self.questionIndex += 1
        if (self.questionIndex == self.quiz.questions.count) {
            showQuizEndingView()
            return
        }
        self.responseListView.isHidden = true
        self.currentQuestion = self.quiz.questions[self.questionIndex]
        self.loadQuestionsAnswers()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func leaveButtonPressed(_ sender: Any) {
        showQuizEndingView()
    }
    
    func showQuizEndingView() {
        let quizEndView = QuizEndViewController()
        quizEndView.goodAnswersNumber = self.goodAnswerNumber
        quizEndView.quiz = self.quiz
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(quizEndView, animated: true)
    }
}


extension QuizQuestionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentQuestion.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell") ?? UITableViewCell(style: .default, reuseIdentifier: "answerCell")
        cell.textLabel?.text = self.currentQuestion.answers[indexPath.row].content
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    
}

extension QuizQuestionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.answerChoosen(isGoodAnswer: self.currentQuestion.answers[indexPath.row].isRightAnswer)
    }
}
