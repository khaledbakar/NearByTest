//
//  RestaurantVC.swift
//  GoGTest
//
//  Created by mac on 10/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController {
    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var oneRS: UIImageView!
    @IBOutlet weak var twoRS: UIImageView!
    @IBOutlet weak var threeRS: UIImageView!
    @IBOutlet weak var fourRS: UIImageView!
    @IBOutlet weak var fiveRS: UIImageView!

    @IBOutlet weak var imgFavP: UIImageView!
    var singleItem:RestuItems?
    var singleSignINUser : SigninVC?

    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = singleItem?.placeName
        lblOpen.text = singleItem?.openNow
        imgUrl(imgR: (singleItem?.imgRestu)!)
        lblType.text = singleItem?.typeR
     //   lblLocation.text! = "\(singleItem?.addresGemLat),\(singleItem?.addresGemLang)"
        lblLocation.text = (singleItem?.addresGemLat)! + ", " + (singleItem?.addresGemLang)!
        let dRate = singleItem?.rateG
        let tempRate = (dRate as! NSString).doubleValue
        if tempRate >= 1.0 && tempRate < 2.0  {
            oneRS.image! = UIImage(named: "star_rating")!
            
        }
        else if tempRate >= 2.0 && tempRate < 3.0 {
            oneRS.image! = UIImage(named: "star_rating")!
            twoRS.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 3.0 && tempRate < 4.0 {
            oneRS.image! = UIImage(named: "star_rating")!
            twoRS.image! = UIImage(named: "star_rating")!
            threeRS.image! = UIImage(named: "star_rating")!
            
        }
        else if tempRate >= 4.0 && tempRate < 5.0 {
            oneRS.image! = UIImage(named: "star_rating")!
            twoRS.image! = UIImage(named: "star_rating")!
            threeRS.image! = UIImage(named: "star_rating")!
            fourRS.image! = UIImage(named: "star_rating")!
        }
        else if tempRate >= 5.0 {
            oneRS.image! = UIImage(named: "star_rating")!
            twoRS.image! = UIImage(named: "star_rating")!
            threeRS.image! = UIImage(named: "star_rating")!
            fourRS.image! = UIImage(named: "star_rating")!
            fiveRS.image! = UIImage(named: "star_rating")!
            
        }
     
    }

   
    @IBAction func buDis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func favPlaceBu(_ sender: Any) {
        if imgFavP.image == UIImage(named: "fav_resic"){
            
        imgFavP.image == UIImage(named: "favred_ic")
        let newPlace = FavPlaces(context: context)
        newPlace.name_fp = singleItem?.placeName
        newPlace.open_fv = singleItem?.openNow
        newPlace.imgurl_fv = singleItem?.imgRestu
        newPlace.rate_fp = singleItem?.rateG
        newPlace.type_fv = singleItem?.typeR
        newPlace.lang_fv = singleItem?.addresGemLang
        newPlace.lat_fv = singleItem?.addresGemLat
        newPlace.username_fk = SigninVC.fkUserName
        do {
        ad.saveContext()
            print(SigninVC.fkUserName)
            print("saved")
        } catch {
            print("Error")
        }
            
        }
        
    }
    func imgUrl(imgR:String)  {
        if let url = URL(string: imgR){
            do{
                let data = try Data(contentsOf: url)
                self.imgRest.image = UIImage(data: data)

            } catch let err{
                print("Error : \(err.localizedDescription)")
            }
            
        }
    }

   

}
