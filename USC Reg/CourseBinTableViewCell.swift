//
//  CourseBinTableViewCell.swift
//  USC Reg
//
//  Created by Saurabh Jain on 2/22/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class CourseBinTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var beginTime: UILabel!
    @IBOutlet weak var instructor: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var location: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
