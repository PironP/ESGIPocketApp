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
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classStartLabel: UILabel!
    @IBOutlet weak var classRoomLabel: UILabel!
    @IBOutlet weak var noPlanningLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.text = "Bonjour, " + CurrentUser.currentUser.firstname.capitalized + " " + CurrentUser.currentUser.lastname.capitalized
        
        self.nextClassView.isHidden = true
        loadNextClass()
        
//        print(CurrentUser.currentUser.classe?.id)
//        print(CurrentUser.currentUser.classe?.group)
//        print(CurrentUser.currentUser.classe?.specialityAcronym)
//        print(CurrentUser.currentUser.classe?.year)
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
                print("resonse is empty")
                self.noPlanningLabel.isHidden = false
                return
            }
            let classes = response[0].content
            // find first
            let nextClass = classes[0]
            print(response[0])
            // field label with newtClass
            DispatchQueue.main.async {
                self.nextClassView.isHidden = false
            }
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
        print(basePath)
        
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
