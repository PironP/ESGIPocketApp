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

    
    var classes: [Classe]  = []
    
    @IBOutlet weak var classPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.classPickerView.dataSource = self
        self.classPickerView.delegate = self
        
        // If currentuser token is not set try login
        
        let classeProvider = ClasseProvider()
        classeProvider.getSection { (response) in
            if response.count == 0 {
                print("no result")
                return
            }
            self.classes = response
            self.classPickerView.reloadAllComponents()
        }
        

        //classPickerView.dataSource = classes as! UIPickerViewDataSource;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SelectClassViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.classes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.classes[row].specialityAcronym + " " + self.classes[row].group + " " + self.classes[row].year
    }
    
}

extension SelectClassViewController: UIPickerViewDelegate {
    
}
