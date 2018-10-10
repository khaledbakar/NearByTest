//
//  FavPlacesViewCell.swift
//  GoGTest
//
//  Created by mac on 10/7/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class FavPlacesViewCell: UITableViewCell {

    @IBOutlet weak var FiveSP: UIImageView!
    @IBOutlet weak var fourSP: UIImageView!
    @IBOutlet weak var threeSP: UIImageView!
    @IBOutlet weak var twoSP: UIImageView!
    @IBOutlet weak var oneSP: UIImageView!
    @IBOutlet weak var lblOpenP: UILabel!
    @IBOutlet weak var lblNameP: UILabel!
    @IBOutlet weak var lblTypeP: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(favPl:FavPlaces)  {
        lblNameP.text = favPl.name_fp
        if  favPl.open_fv == "null" {
            lblOpenP.isHidden = true
        }
        lblOpenP.text = "open now :\(favPl.open_fv)"
        lblTypeP.text = favPl.type_fv
        let dRate = favPl.rate_fp
        let tempRate = (dRate as! NSString).doubleValue
        if tempRate >= 1.0 && tempRate < 2.0  {
            oneSP.image! = UIImage(named: "star_rating")!             
        }
        else if tempRate >= 2.0 && tempRate < 3.0 {
            oneSP.image! = UIImage(named: "star_rating")!
            twoSP.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 3.0 && tempRate < 4.0 {
            oneSP.image! = UIImage(named: "star_rating")!
            twoSP.image! = UIImage(named: "star_rating")!
            threeSP.image! = UIImage(named: "star_rating")!
            
        }
        else if tempRate >= 4.0 && tempRate < 5.0 {
            oneSP.image! = UIImage(named: "star_rating")!
            twoSP.image! = UIImage(named: "star_rating")!
            threeSP.image! = UIImage(named: "star_rating")!
            fourSP.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 5.0 {
            oneSP.image! = UIImage(named: "star_rating")!
            twoSP.image! = UIImage(named: "star_rating")!
            threeSP.image! = UIImage(named: "star_rating")!
            fourSP.image! = UIImage(named: "star_rating")!
            FiveSP.image! = UIImage(named: "star_rating")!
            
        }
    }

}
