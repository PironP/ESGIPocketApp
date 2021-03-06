//
//  QuizListViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuizListViewController: UIViewController {

    var idTopic: String!
    var quizList: [Quiz] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noQuizLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        
        let quizProvider = QuizProvider()
        quizProvider.getQuizzes(callback: { response in

            self.quizList = response.filter({ (quiz) -> Bool in
                quiz.topic.id == self.idTopic
            })
            
            DispatchQueue.main.async {
                if self.quizList.count == 0 {
                    self.noQuizLabel.isHidden = false
                    return
                }
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


extension QuizListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell") ?? UITableViewCell(style: .default, reuseIdentifier: "quizCell")
        cell.textLabel?.text = self.quizList[indexPath.row].name
        
        return cell
 
    }
        
}

extension QuizListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let quizPresentationView = QuizPresentationViewController()
        quizPresentationView.quiz = quizList[indexPath.row]
        navigationController?.pushViewController(quizPresentationView, animated: true)
        
    }
    
}
