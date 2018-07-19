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
    @IBOutlet weak var returnButton: UIButton!
    
    var users: [User] = []
    var usersList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        getUser()
        
        if (CurrentUser.currentUser.role == 3) {
            returnButton.isHidden = true
            userFilter.removeSegment(at: 2, animated: false)
        }
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
            self.getPrivatesMessages()

        })
    }
    
    func getPrivatesMessages() {
        let messageProvider = MessageProvider()
        messageProvider.getAllPrivateMessages(callback: { response in
            
            for user in self.users {
                user.privateMessage = response.filter({ (message) -> Bool in
                    message.receiverId == user.id
                })
            }
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
            usersList = users.filter({ (user) -> Bool in
                user.role != 3
                
            })
        case 1:
            usersList = users.filter({ (user) -> Bool in
                user.role == 3
            })
        case 2:
            guard let classeId = CurrentUser.currentUser.classe?.id else {
                return
            }
            usersList = users.filter({ (user) -> Bool in
                user.classe.id == classeId
            })
        default:
            usersList = users
        }
        
        if queryTextField.text != "" {
            searchUser()
        }
        
        usersList = usersList.filter({ (user) -> Bool in
            user.id != CurrentUser.currentUser.id
        })
        
        self.sortUsersByMessagesCount()
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
    
    func sortUsersByMessagesCount() {
        self.usersList.sort(by: { (user1, user2) -> Bool in
            return user1.privateMessage.count >= user2.privateMessage.count
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
