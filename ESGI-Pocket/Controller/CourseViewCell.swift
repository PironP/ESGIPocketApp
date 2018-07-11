//
//  CourseViewCell.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 11/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import UIKit

class CourseViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseAuthor: UILabel!
    @IBOutlet weak var votePro: UILabel!
    @IBOutlet weak var voteCons: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
