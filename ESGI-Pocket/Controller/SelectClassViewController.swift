//
//  SelectClassViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 14/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectClassViewController: UIViewController {

    
    var classes = JSON()
    
    @IBOutlet weak var classPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If currentuser token is not set try login
        
        //classPickerView.dataSource = classes as! UIPickerViewDataSource;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
