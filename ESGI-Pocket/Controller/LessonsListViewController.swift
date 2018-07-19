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
    var showArchive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.register(UINib(nibName: "CourseViewCell", bundle: nil), forCellReuseIdentifier: "courseCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let courseProvider = CourseProvider()
        courseProvider.getTopicCourses(idTopic: self.idTopic, callback: { response in
            if response.count == 0 {
                self.noCoursesLabel.text? = "Personne n'a partagé de cours pour cette matière. N'hésite pas à partager le tien depuis notre application pour PC."
                self.noCoursesLabel.isHidden = false
                return
            }
            self.courses = response
            self.sortCoursesList()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
            
        })
    }
    
    func sortCoursesList() {
        self.courses.sort(by: { (course1, course2) -> Bool in
            if !course1.archive && course2.archive {
                return true
            } else if course1.archive && !course2.archive {
                return false
            } else {
                return (course1.like - course1.dislike) >= (course2.like - course2.dislike) ? true : false
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func archiveSwitchChanged(_ sender: Any) {
        self.showArchive = !self.showArchive
        self.tableView.reloadData()
    }
    
}

extension LessonsListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showArchive {
            return self.courses.count
        } else {
            return self.courses.filter({ (course) -> Bool in
                return !course.archive
            }).count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        if let listCell = cell as? CourseViewCell {
            listCell.courseTitle.text = courses[indexPath.row].title
            listCell.courseAuthor.text = courses[indexPath.row].authorName
            listCell.like.text = courses[indexPath.row].like.description
            listCell.dislike.text = courses[indexPath.row].dislike.description
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension LessonsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let url = URL(string: self.courses[indexPath.row].content) {
//            UIApplication.shared.open(url)
//        }
        let lessonView = LessonViewController()
        lessonView.course = self.courses[indexPath.row]
        navigationController?.pushViewController(lessonView, animated: true)
    }
    
}
