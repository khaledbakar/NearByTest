//
//  TableViewCell.swift
//  GoGTest
//
//  Created by mac on 10/2/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var oneS: UIImageView!
    @IBOutlet weak var lblPlaces: UILabel!
    @IBOutlet weak var threeS: UIImageView!
    @IBOutlet weak var twoS: UIImageView!
    @IBOutlet weak var lblOpenHours: UILabel!
    @IBOutlet weak var fourS: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var fiveS: UIImageView!
    @IBOutlet weak var vColor: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
