//
//  DiscussionViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 18/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscussionViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var idDiscussion = ""
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageTextField.delegate = self
        
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        self.tableView.separatorStyle = .none
        self.tableView?.rowHeight = 75.0
        loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadMessages() {
        let messageProvider = MessageProvider()
        messageProvider.getThreadMessages(threadId: self.idDiscussion, callback: { response in
            if response.count == 0 {
                return
            }
            self.messages = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
            }
        })
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        
        guard let message = self.messageTextField.text else {
            return
        }

        if message.count == 0 {
            return
        }
        
        let messageModel = MessageProvider()
        messageModel.sendThreadMessage(message: message, idDiscussion: self.idDiscussion) { (result) in
            if (result) {
                self.messageTextField.text? = ""
                self.loadMessages()
            }
        }
    }
}

extension DiscussionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
         if let listCell = cell as? MessageViewCell {
            listCell.messageLabel.text = messages[indexPath.row].message
            listCell.timestampLabel.text = messages[indexPath.row].createdAt
            listCell.usernameLabel.text =  messages[indexPath.row].user.firstname + " " + messages[indexPath.row].user.lastname
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

extension DiscussionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
