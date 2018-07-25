//
//  LessonViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 11/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import WebKit

class LessonViewController: UIViewController {

    var course: Course!
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseAuthor: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseTitle.text = course.title
        getVote()
        
        courseAuthor.text = course.authorName
        
        if let courseUrl = course.url {
            let url: URL = URL(string: courseUrl)!
            let request = URLRequest(url: url)
            webView.load(request)
            return
        }
        if let courseContent = course.content {
            
            webView.isHidden = true
            return
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getVote() {
        self.likeButton.isEnabled = false
        self.dislikeButton.isEnabled = false
        let courseProvider = CourseProvider()
        courseProvider.getVoteForCourse(idCourse: course.id) { response in
            if (response["vote"].exists()) {
                if response["vote"].boolValue {
                    self.enableDisLikeButton()
                } else {
                    self.enableLikeButton()
                }
            } else {
                self.likeButton.isEnabled = true
                self.dislikeButton.isEnabled = true
            }
        }
    }
    
    func enableLikeButton() {
        self.likeButton.setImage(UIImage(named: "item-like"), for: UIControlState.normal)
        self.dislikeButton.setImage(UIImage(named: "item-dislike-fill"), for: UIControlState.normal)
        self.likeButton.isEnabled = true
        self.dislikeButton.isEnabled = false
    }
    
    func enableDisLikeButton() {
        self.likeButton.setImage(UIImage(named: "item-like-fill"), for: UIControlState.normal)
        self.dislikeButton.setImage(UIImage(named: "item-dislike"), for: UIControlState.normal)
        self.likeButton.isEnabled = false
        self.dislikeButton.isEnabled = true
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func voteForCourse(_ sender: UIButton) {

        let courseProvider = CourseProvider()
        courseProvider.addVoteForCourse(idCourse: course.id, like: sender.tag == 0 ? true : false) { response in
            if response {

                if sender.tag == 0 {
                    self.enableDisLikeButton()
                } else {
                    self.enableLikeButton()
                }
            }
        }
    }
    
}
