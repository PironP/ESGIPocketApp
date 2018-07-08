//
//  PlanningViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class PlanningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
