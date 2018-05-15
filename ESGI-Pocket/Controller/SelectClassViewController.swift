//
//  SelectClassViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 14/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class SelectClassViewController: UIViewController {

    
    var classes: [[String:Any]] = []
    
    @IBOutlet weak var classPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        classPickerView.dataSource = classes as! UIPickerViewDataSource;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
