//
//  LessonsListViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class LessonsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var idTopic = ""
    @IBOutlet weak var noCoursesLabel: UILabel!
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        
        let courseProvider = CourseProvider()
        courseProvider.getTopicCourses(idTopic: self.idTopic, callback: { response in
            if response.count == 0 {
                self.noCoursesLabel.text? = "Personne n'a partagé de cours pour cette matière. N'hésite pas à partager le tien depuis notre application pour PC."
                self.noCoursesLabel.isHidden = false
                return
            }
            self.courses = response
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
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension LessonsListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell") ?? UITableViewCell(style: .default, reuseIdentifier: "coursesCell")
        cell.textLabel?.text = courses[indexPath.row].title
        
        return cell
    }
    
}

extension LessonsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let url = URL(string: self.courses[indexPath.row].content) {
            UIApplication.shared.open(url)
        }
    }
    
}
