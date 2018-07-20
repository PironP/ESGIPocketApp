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
    var selectedClass: Classe?
    
    @IBOutlet weak var classPickerView: UIPickerView!
    @IBOutlet weak var selectedClassLabel: UILabel!
    @IBOutlet weak var confimClassButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.classPickerView.isHidden = true
        self.classPickerView.dataSource = self
        self.classPickerView.delegate = self
        self.confimClassButton.isEnabled = false
        
        // If currentuser token is not set try login
        
        let classeProvider = ClasseProvider()
        
        classeProvider.getClasses(callback: { (response) in
            if response.count == 0 {
                self.navigationController?.popViewController(animated: true)
                return
            }
            self.classes = response
            self.classPickerView.reloadAllComponents()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func selectClassButtonPressed(_ sender: Any) {
        self.classPickerView.isHidden = false
    }
    
    @IBAction func confirmClassButtonPressed(_ sender: Any) {
        guard let classe = selectedClass else {
            return
        }
        let userProvider = UserProvider()
        userProvider.selectClassForUser(idClass: classe.id, idUser: CurrentUser.currentUser.id) { (response) in
            if response {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedClass = classes[row]
        if let classe = selectedClass  {
            self.selectedClassLabel.text = classe.specialityAcronym + " " + classe.group + " " + classe.year
        }
        self.confimClassButton.isEnabled = true
    }
}
