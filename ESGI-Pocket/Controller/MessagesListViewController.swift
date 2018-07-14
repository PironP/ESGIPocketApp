//
//  MessagesListViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessagesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var userFilter: UISegmentedControl!
    
    var users: [User] = []
    var usersList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        getUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUser() {
        let userProvider = UserProvider()
        userProvider.getUsers(callback: { response in
            if response.count == 0 {
                return
            }
            self.users = response
            DispatchQueue.main.async {
                self.filterUser(self)
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
            
        })
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterUser(_ sender: Any) {
        switch self.userFilter.selectedSegmentIndex {
        case 0:
            guard let classeId = CurrentUser.currentUser.classe?.id else {
                return
            }
            usersList = users.filter({ (user) -> Bool in
                user.classe.id == classeId
            })
        case 1:
            usersList = users.filter({ (user) -> Bool in
                user.role != 3
            })
        case 2:
            usersList = users.filter({ (user) -> Bool in
                user.role == 3
            })
        default:
            usersList = users
        }
        
        if queryTextField.text != "" {
            searchUser()
        }
        
        self.tableView.reloadData()
    }
    
    func searchUser() {
        guard let nameSearched = self.queryTextField.text?.lowercased() else {
            return
        }
        usersList = usersList.filter({ (user) -> Bool in
            return user.lastname.lowercased().range(of: nameSearched) != nil || user.firstname.lowercased().range(of: nameSearched) != nil
        })
    }
}

extension MessagesListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") ?? UITableViewCell(style: .default, reuseIdentifier: "topicCell")
        cell.textLabel?.text = self.usersList[indexPath.row].firstname + " " + self.usersList[indexPath.row].lastname
        return cell
    }
    
}

extension MessagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let discussionView = DiscussionViewController()
        discussionView.idReceiver = self.usersList[indexPath.row].id
        discussionView.nameDiscussion = self.usersList[indexPath.row].firstname + " " + self.usersList[indexPath.row].lastname
        navigationController?.pushViewController(discussionView, animated: true)
    }
    
}
