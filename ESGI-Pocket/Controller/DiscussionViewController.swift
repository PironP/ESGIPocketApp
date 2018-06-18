//
//  DiscussionViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 18/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var idDiscussion = ""
    var messages = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        
        // get message for idDiscussion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        var dict = Dictionary<String, Any>()
        dict = ["message" : message, "discussion" : self.idDiscussion]
        
        let messageModel = Message()
        messageModel.sendMessage(message: dict) { (result) in
            if (result) {
                self.messageTextField.text? = ""
                // reload messages
            }
        }
    }
}

extension DiscussionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") ?? UITableViewCell(style: .default, reuseIdentifier: "messageCell")
        cell.textLabel?.text = messages[indexPath.row]["message"] as! String
        
        return cell
    }
    
}
