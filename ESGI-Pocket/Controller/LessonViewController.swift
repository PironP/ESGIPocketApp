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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseTitle.text = course.title
        
        let url: URL = URL(string: course.content)!
        let request = URLRequest(url: url)
        webView.load(request)
        
//        webView = WKWebView(frame: self.view.frame)
//        self.view.addSubview(self.view.webView)
//        webView.navigationDelegate = self
//        webView.loadHTMLString(htmlString, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
