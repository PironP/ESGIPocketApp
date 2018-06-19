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
    var topics = JSON()
    var fileTypeRequestd: Int! // 1 for quiz 2 for courses
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        
        let topicProvider = TopicProvider()
        topicProvider.getTopic(callback: { response in
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
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func homeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension TopicViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") ?? UITableViewCell(style: .default, reuseIdentifier: "topicCell")
        cell.textLabel?.text = topics[indexPath.row]["name"].stringValue
        
        return cell
    }
    
}

extension TopicViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.fileTypeRequestd == 2 {
            let lessonsListView = LessonsListViewController()
            lessonsListView.idTopic = self.topics[indexPath.row]["_id"].stringValue
            self.present(lessonsListView, animated: true, completion: nil)
        } else {
            let quizListView = QuizListViewController()
            quizListView.idTopic = self.topics[indexPath.row]["_id"].stringValue
            self.present(quizListView, animated: true, completion: nil)
        }

    }
    
}
