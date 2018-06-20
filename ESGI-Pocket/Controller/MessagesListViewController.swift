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
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchUser(username: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchUser(username: String) {
        let userProvider = UserProvider()
        userProvider.getUser(username: username, callback: { response in
            if response.count == 0 {
                return
            }
            self.users = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
            
        })
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchUser(username: self.queryTextField.text!)
    }
    @IBAction func returnButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MessagesListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") ?? UITableViewCell(style: .default, reuseIdentifier: "topicCell")
        cell.textLabel?.text = self.users[indexPath.row].firstname + " " + self.users[indexPath.row].lastname
        return cell
    }
    
}

extension MessagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
