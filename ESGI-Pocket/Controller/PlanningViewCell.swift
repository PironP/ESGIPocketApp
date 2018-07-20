//
//  PlanningViewCell.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class PlanningViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classRoom: UILabel!
    @IBOutlet weak var classDate: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundedView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
