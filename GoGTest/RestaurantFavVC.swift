//
//  RestaurantFavVC.swift
//  GoGTest
//
//  Created by mac on 10/9/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class RestaurantFavVC: UIViewController {
    
    @IBOutlet weak var imgRestFav: UIImageView!
    @IBOutlet weak var oneRSFav: UIImageView!
    @IBOutlet weak var twoRSFav: UIImageView!
    @IBOutlet weak var threeRSFav: UIImageView!
    @IBOutlet weak var fourRSFav: UIImageView!
    @IBOutlet weak var fiveRSFav: UIImageView!

    
    @IBOutlet weak var imgFavPFav: UIImageView!
    var singleItem:RestuItems?
    var singleSignINUser : SigninVC?
    
    @IBOutlet weak var lblOpenFav: UILabel!
    @IBOutlet weak var lblNameFav: UILabel!
    @IBOutlet weak var lblTypeFav: UILabel!
    @IBOutlet weak var lblLocationFav: UILabel!
    var singleFavSeguItem : FavPlaces?
    override func viewDidLoad() {
        super.viewDidLoad()
lblNameFav.text = singleFavSeguItem?.name_fp
lblOpenFav.text = singleFavSeguItem?.open_fv
    imgUrlFav(imgR: (singleFavSeguItem?.imgurl_fv)!)
        lblTypeFav.text = singleFavSeguItem?.type_fv
        lblLocationFav.text = (singleFavSeguItem?.lat_fv)! + ", " + (singleFavSeguItem?.lat_fv)!
        let dRate = singleFavSeguItem?.rate_fp
        let tempRate = (dRate as! NSString).doubleValue
        if tempRate >= 1.0 && tempRate < 2.0  {
            oneRSFav.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 2.0 && tempRate < 3.0 {
            oneRSFav.image! = UIImage(named: "star_rating")!
            twoRSFav.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 3.0 && tempRate < 4.0 {
            oneRSFav.image! = UIImage(named: "star_rating")!
            twoRSFav.image! = UIImage(named: "star_rating")!
            threeRSFav.image! = UIImage(named: "star_rating")!
            
        }
        else if tempRate >= 4.0 && tempRate < 5.0 {
            oneRSFav.image! = UIImage(named: "star_rating")!
            twoRSFav.image! = UIImage(named: "star_rating")!
            threeRSFav.image! = UIImage(named: "star_rating")!
            fourRSFav.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 5.0 {
            oneRSFav.image! = UIImage(named: "star_rating")!
            twoRSFav.image! = UIImage(named: "star_rating")!
            threeRSFav.image! = UIImage(named: "star_rating")!
            fourRSFav.image! = UIImage(named: "star_rating")!
            fiveRSFav.image! = UIImage(named: "star_rating")!
            
        }
        
    }
    func imgUrlFav(imgR:String)  {
        if let url = URL(string: imgR){
            do{
                let data = try Data(contentsOf: url)
                self.imgRestFav.image = UIImage(data: data)
                
            } catch let err{
                print("Error : \(err.localizedDescription)")
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backFvBu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
