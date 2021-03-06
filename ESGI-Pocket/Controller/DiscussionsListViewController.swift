//
//  DiscussionsListViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscussionsListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var discussions: [Thread] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()

        let discussionProvider = DiscussionProvider()
        discussionProvider.getDiscussions(callback: { response in
            if response.count == 0 {
                return
            }
            self.discussions = response
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func privateMessageButtonPressed(_ sender: Any) {
        let messageListView = MessagesListViewController()
        navigationController?.pushViewController(messageListView, animated: true)
    }
    
}

extension DiscussionsListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discussions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "discussionCell") ?? UITableViewCell(style: .default, reuseIdentifier: "discussionCell")
        cell.textLabel?.text = discussions[indexPath.row].name

        return cell
    }
    
}

extension DiscussionsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let discussionView = DiscussionViewController()
        discussionView.idDiscussion = self.discussions[indexPath.row].id
        discussionView.nameDiscussion = self.discussions[indexPath.row].name
        navigationController?.pushViewController(discussionView, animated: true)
    }

}

