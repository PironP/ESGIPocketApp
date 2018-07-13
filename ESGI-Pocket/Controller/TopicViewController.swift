//
//  TopicViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class TopicViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var topics: [Topic] = []
    var fileTypeRequestd: Int! // 1 for quiz 2 for courses
    var filterByClasse: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        
        loadTopics()
        
    }
    
    @IBAction func filterTopicByClassSwitchChanged(_ sender: Any) {
        filterByClasse = !filterByClasse
        loadTopics()
    }
    
    func loadTopics() {
        filterByClasse ? loadClassesTopics() : loadAllTopics()
    }
    
    func loadClassesTopics() {
        if let classeTopics = CurrentUser.currentUser.classe?.topics {
            
            self.topics = classeTopics
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func loadAllTopics() {
        let topicProvider = TopicProvider()
        topicProvider.getAllTopics(callback: { response in
            if response.count == 0 {
                return
            }
            self.topics = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
            
        })
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func homeButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension TopicViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") ?? UITableViewCell(style: .default, reuseIdentifier: "topicCell")
        cell.textLabel?.text = topics[indexPath.row].name
        
        return cell
    }
    
}

extension TopicViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.fileTypeRequestd == 2 {
            let lessonsListView = LessonsListViewController()
            lessonsListView.idTopic = self.topics[indexPath.row].id
            navigationController?.pushViewController(lessonsListView, animated: true)
        } else {
            let quizListView = QuizListViewController()
            quizListView.idTopic = self.topics[indexPath.row].id
            navigationController?.pushViewController(quizListView, animated: true)
        }

    }
    
}
