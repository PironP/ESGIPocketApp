//
//  ConfirmEmailViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 28/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class ConfirmEmailViewController: UIViewController {

    @IBOutlet weak var codePart1: UITextField!
    
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newCodeBtnPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func activateAccountBtnPressed(_ sender: Any) {
        
        let loginModel = Login()
        
        guard let validationCode = codePart1.text! as? String else {
            return
        }
        
        loginModel.checkValidationCode(id: userId, validationCode: validationCode, callback: { response in
            if response {
                let selectClassViewController = SelectClassViewController()
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(selectClassViewController, animated: true)

            }
            else {
                // Show error message : " Validation  code is not correct"
            }
        })
        
    }
    
}
