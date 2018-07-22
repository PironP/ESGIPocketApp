//
//  HomeViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 09/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    var jwt: String = ""
    
    @IBOutlet weak var nextClassView: UIView!
    @IBOutlet weak var nextClassLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classStartLabel: UILabel!
    @IBOutlet weak var classRoomLabel: UILabel!
    @IBOutlet weak var noPlanningLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.text = "Bonjour " + CurrentUser.currentUser.firstname.capitalized + " " + CurrentUser.currentUser.lastname.capitalized + ","
        
        self.nextClassView.isHidden = true
        loadNextClass()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadNextClass() {
        let planningProvider = PlanningProvider()
        guard let idClass = CurrentUser.currentUser.classe?.id else {
            self.noPlanningLabel.isHidden = false
            return
        }
        planningProvider.getClassPlanning(idClass: idClass, callback: { response in
            if response.isEmpty {
                self.noPlanningLabel.isHidden = false
                return
            }
            let classes = response[0]
            // find first
            if classes.items.count == 0 {
                self.nextClassLabel.isHidden = true
                self.noPlanningLabel.isHidden = false
                return
            }
            let nextClass = classes.items[0]
            // field label with newtClass
            self.nextClassView.isHidden = false
            self.nextClassView.layer.cornerRadius = 10
            self.classNameLabel.text = nextClass.topic
            self.classRoomLabel.text = nextClass.room
            guard let nextClassDate = nextClass.date.split(separator: " ").first?.description else {
                self.classStartLabel.text = nextClass.date + " " + nextClass.startTime
                return
            }
            self.classStartLabel.text = nextClassDate + " " + nextClass.startTime

            
        })
    }
    
    @IBAction func navigationButtonPressed(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            let  topicView = TopicViewController()
            topicView.fileTypeRequestd = 1
            navigationController?.pushViewController(topicView, animated: true)
        case 1:
            let  topicView = TopicViewController()
            topicView.fileTypeRequestd = 2
            navigationController?.pushViewController(topicView, animated: true)
        case 2:
            let discussionsListView = DiscussionsListViewController()
            navigationController?.pushViewController(discussionsListView, animated: true)
        case 3:
            let planningView = PlanningViewController()
            navigationController?.pushViewController(planningView, animated: true)
        default:
            return
        }
    }
    
    @IBAction func navigationButton(_ sender: Any) {
    }
    
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        
        let basePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("loginDetails.json")
        
        let dict = ["email" :"", "password" :""]
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0)) else {
            return
        }
        do {
            try data.write(to: filePath)
        } catch {
            
        }
        
        CurrentUser.currentUser.jwt = ""
        
        let loginView = LoginViewController()
        navigationController?.popViewController(animated: true)
    }
}
