//
//  PlanningViewController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 16/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class PlanningViewController: UIViewController {

    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var noPlanningLabel: UILabel!
    var planningItems: [PlanningItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listView.dataSource = self
        self.listView.register(UINib(nibName: "PlanningViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        self.listView.tableFooterView = UIView()
        self.listView.separatorStyle = .none
        self.listView.allowsSelection = false
        self.listView.isHidden = true
        self.noPlanningLabel.isHidden = true
        
        loadPanning()
    }
    
    func loadPanning() {
        let planningProvider = PlanningProvider()
        guard let idClass = CurrentUser.currentUser.classe?.id else {
            self.noPlanningLabel.isHidden = false
            return
        }
        planningProvider.getClassPlanning(idClass: idClass, callback: { response in
            if response.isEmpty {
                self.noPlanningLabel.isHidden = false
                return
            }
            let classes = response[0]
            
            if classes.items.count == 0 {
                self.noPlanningLabel.isHidden = false
                return
            }
            self.planningItems = classes.items
            
            DispatchQueue.main.async {
                self.listView.reloadData()
                self.listView.isHidden = false
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
    
}

extension PlanningViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planningItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
        
        if let listCell = cell as? PlanningViewCell {
            listCell.className.text = self.planningItems[indexPath.row].topic
            listCell.classRoom.text = self.planningItems[indexPath.row].room
            listCell.startTime.text = self.planningItems[indexPath.row].startTime
            listCell.endTime.text = self.planningItems[indexPath.row].endTime
            guard let nextClassDate = self.planningItems[indexPath.row].date.split(separator: " ").first?.description else {
                listCell.classDate.text = self.planningItems[indexPath.row].date
                return cell
            }
            listCell.classDate.text = nextClassDate
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    
}
