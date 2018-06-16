//
//  DiscussionsListViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class DiscussionsListViewController: UIViewController {

    @IBOutlet weak var discussionTableView: UITableView!
    var discussions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func homeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DiscussionsListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discussions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discussionCell", for: indexPath)
        cell.textLabel?.text = discussions[indexPath.row]
//        if let listCell = cell as? UITableViewCell {
//            listCell.titleList.text = self.request.titles[indexPath.row]
//            listCell.channelTitleList.text = self.request.channelTitles[indexPath.row]
//            listCell.imageList.image = self.request.imageList[indexPath.row]
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DiscussionsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let videoId = self.request.id[indexPath.row]
        let descriptionVideo = self.request.descriptions[indexPath.row]
        let videoImage = self.request.imageList[indexPath.row]
        let videoName = self.request.titles[indexPath.row]
        let videoChannel = self.request.channelTitles[indexPath.row]
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId
        videoViewController.descriptionVideo = descriptionVideo
        videoViewController.videoImage = videoImage
        videoViewController.videoName = videoName
        videoViewController.videoChannel = videoChannel
        self.navigationController?.pushViewController(videoViewController, animated: true)*/
    }

}

