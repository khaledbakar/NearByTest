//
//  ViewController.swift
//  GoGTest
//
//  Created by mac on 9/25/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import MapKit
class ViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate , CLLocationManagerDelegate {
   var RestuList = Array<RestuItems>()
    var sections = ["Favourite Places","Nearby Places"]
    var mainFavList = [FavPlaces]()
    let locationManger = CLLocationManager()

    @IBOutlet weak var tblPl: UITableView!
    var aR :[String] = []
    var openHour :[String] = []
    var typeSArr :[String] = []
    var latGArr :[String] = []
    var langGArr :[String] = []
    var rateGArr :[String] = []
    var imgUrlArr :[String] = []
    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.delegate = self
        tblPl.isHidden = true
        tblPl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tblPl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.startUpdatingLocation()
        }
        loadMainFavPlaces()
    }
    
    func loadMainFavPlaces()  {
      //  let restu = "restaurant"   Comfort inn  restaurant
        let resta = "Comfort inn"
        let fetchRequest:NSFetchRequest<FavPlaces> = FavPlaces.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username_fk == %@", SigninVC.fkUserName)
        do {
        
            mainFavList = try context.fetch(fetchRequest)
            tblPl.reloadData()
        } catch {
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // return secTwo.count
        if section == 0 {
            return mainFavList.count
        } else {
            return aR.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.darkGray
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 15)
        headerLabel.textColor = UIColor.lightText
        headerLabel.text = self.tableView(self.tblPl, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
   
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "restufavdetail", sender: mainFavList[indexPath.row])

        }
        else {
            performSegue(withIdentifier: "restudetail", sender: RestuList[indexPath.row])
            print("the segue data \(RestuList[indexPath.row].placeName)")
        }
    }
    
    @IBAction func distBu(_ sender: Any) {
     //   performSegue(withIdentifier: <#T##String#>, sender: mainFavList[indexp])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? RestaurantVC {
            if let Restu = sender as? RestuItems {
                dis.singleItem = Restu
                print ("the single Vc : \(Restu)")
            }
        }
        if let disFav = segue.destination as? RestaurantFavVC {
            if let RestuFav = sender as? FavPlaces {
                disFav.singleFavSeguItem = RestuFav
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let  cell = tableView.dequeueReusableCell(withIdentifier: "tblcell") as! TableViewCell
       
        if indexPath.section == 0 {
            if mainFavList[indexPath.row].name_fp!.trimmingCharacters(in: .whitespaces) == "" || mainFavList[indexPath.row].name_fp! == nil || mainFavList[indexPath.row].name_fp! == "null" {
                cell.lblPlaces.text! = "NO NAME"
                       }
            else{
                cell.lblPlaces.text! = mainFavList[indexPath.row].name_fp!

            }
            if mainFavList[indexPath.row].open_fv == "null"{
                cell.lblOpenHours.isHidden = true
            }
            else{
                cell.lblOpenHours.isHidden = false
                cell.lblOpenHours.text! =  "open now : \(mainFavList[indexPath.row].open_fv!)"
            }
            cell.lblType.text! = mainFavList[indexPath.row].type_fv!
            // rate cell
            let dRate = mainFavList[indexPath.row].rate_fp!
            let tempRate = Double(dRate)!
            if tempRate >= 1.0 && tempRate < 2.0  {
                cell.oneS.image! = UIImage(named: "star_rating")!
                
            }
            else if tempRate >= 2.0 && tempRate < 3.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
            }
            else if tempRate >= 3.0 && tempRate < 4.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                
            }
            else if tempRate >= 4.0 && tempRate < 5.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                cell.fourS.image! = UIImage(named: "star_rating")!
            }
            else if tempRate >= 5.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                cell.fourS.image! = UIImage(named: "star_rating")!
                cell.fiveS.image! = UIImage(named: "star_rating")!
            }
        }
            
        else
        {
            cell.lblPlaces.text! = RestuList[indexPath.row].placeName!
            if RestuList[indexPath.row].openNow == "null" {
                cell.lblOpenHours.isHidden = true
                   }
            else {
                cell.lblOpenHours.text! =  "open now : \(RestuList[indexPath.row].openNow!)"
                cell.lblOpenHours.isHidden = false
            }
            cell.lblType.text! = RestuList[indexPath.row].typeR!
          //color view cell
            switch indexPath.row%2 {
            case 1:
                cell.vColor.backgroundColor = UIColor.red
            case 0:
                cell.vColor.backgroundColor = UIColor.blue
            default:
                cell.vColor.backgroundColor = UIColor.orange
            }
           // rate cell
            let dRate = RestuList[indexPath.row].rateG!
            let tempRate = Double(dRate)!
            if tempRate >= 1.0 && tempRate < 2.0  {
                cell.oneS.image! = UIImage(named: "star_rating")!
            }
            else if tempRate >= 2.0 && tempRate < 3.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
            }
            else if tempRate >= 3.0 && tempRate < 4.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                
            }
            else if tempRate >= 4.0 && tempRate < 5.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                cell.fourS.image! = UIImage(named: "star_rating")!
            }
            else if tempRate >= 5.0 {
                cell.oneS.image! = UIImage(named: "star_rating")!
                cell.twoS.image! = UIImage(named: "star_rating")!
                cell.threeS.image! = UIImage(named: "star_rating")!
                cell.fourS.image! = UIImage(named: "star_rating")!
                cell.fiveS.image! = UIImage(named: "star_rating")!
            }
        }
        return cell
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPlaceGoogle(place: textField.text!)
        self.view.endEditing(true)

       // tblPl.isHidden = false
        aR.removeAll()
        openHour.removeAll()
        typeSArr.removeAll()
        RestuList.removeAll()
        return true
    }
    
    func searchPlaceGoogle(place: String)  {
        let apiCode:String = "AIzaSyC8MddP2z3GkY4acnJd3rXr1y9lN0chtb8"
        let sourceLoc = locationManger.location?.coordinate
        print("the loc now: \((sourceLoc?.latitude)!),\((sourceLoc?.longitude)!)")
        DispatchQueue.main.async {
            Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\((sourceLoc?.latitude)!),\((sourceLoc?.longitude)!)&radius=15000&type=\(place)&keyword=cruise&key=\(apiCode)").responseJSON(completionHandler: {(response) in
                switch response.result{
                case.success(let value):
                  //  if let jsonD = response.result.value{
                    //    let nameDic:Dictionary = jsonD as! Dictionary<String, Any>
                      //  let namesDict:Dictionary = nameDic["name"] as! Dictionary<String, Any>
               //         print(namesDict)
                 //   }
                    let json = JSON(value)
                    print(json)
                   // let sJson  = JSONSerialization.jsonObject(with: json, options: [])
                    let resultJson = json["results"]
                    let r1 = resultJson[0]["name"]
                 //   print(r1)
                //    let s:String = r1.string!
                    for ind in 0...10{
                        let r2 = resultJson[ind]["name"]
                        let openH = resultJson[ind]["opening_hours"]["open_now"]
                        let latG = resultJson[ind]["geometry"]["location"]["lat"]
                        let langG = resultJson[ind]["geometry"]["location"]["lng"]
                        let typeSe = resultJson[ind]["types"][0]
                        let rateG = resultJson[ind]["rating"]
                 //       let imgUrl = resultJson[ind]["photos"]["html_attributions"][0]
                        let imgUrl = resultJson[ind]["icon"]

                        if r2 == nil{
                            break
                        }
                        let r3 = "\(r2)"
                        let sOpenH = "\(openH)"
                        let sTypeSe = "\(typeSe)"
                        let sImgUrl = "\(imgUrl)"
                        let sLatG = "\(latG)"
                        let sLangG = "\(langG)"
                        let sRate = "\(rateG)"
                        self.aR.append(r3)
                        self.openHour.append(sOpenH)
                        self.typeSArr.append(sTypeSe)
                        self.latGArr.append(sLatG)
                        self.langGArr.append(sLangG)
                        self.rateGArr.append("\(rateG)")
                        self.imgUrlArr.append(sImgUrl)
                        self.RestuList.append(RestuItems(PlName: r3, OpenN: sOpenH, ImgRestu: sImgUrl, Lang: sLangG, Lat: sLatG, TypeR: sTypeSe,Rate: sRate))
                      //  self.mainFavList.append(RestuItems(PlName: <#T##String#>, OpenN: <#T##String#>, ImgRestu: <#T##String#>, Lang: <#T##String#>, Lat: <#T##String#>, TypeR: <#T##String#>, Rate: <#T##String#>))
                        print(r2)
                        self.tblPl.isHidden = false
                    }
                    print("Array Start")
                   // print(self.RestuList[0].placeName!)
                    print(self.aR)
                    print(self.langGArr)
                    print(self.latGArr)
                    print(self.rateGArr)
                    self.tblPl.reloadData()
                  //  self.tblPlaces.reloadData()
               //     print(s)
                 //       print(resultJson[0]["name"])
                        
                //    }
                    
              //     print(resultJson)

                   // let name = json["name"]
                //    let allNames;[Dictionary<String,AnyObject>] = json["results"]["name"]
                //    for allNames in json["results"]["name"]
                 //   {
                  //      print("the names is : \(allNames) ")
                 //   }
                
                   // print("the name Is : \(name)")
                    // print("--------------------")
                    // print(name["Sydney Showboats"])
              /*      if let dict = json as? Dictionary<String, AnyObject>{
                        if let results = dict["results"] as? [Dictionary<String, AnyObject>]{
                            print("new Json \(results)")
                        }
                    }
                    */
                case.failure(let error):
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: "your daily google places api qouta is finshed", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    self.tblPl.isHidden = true
                }
            })
        }
    }
    @IBAction func favRestBU(_ sender: Any) {
        performSegue(withIdentifier: "favrestu", sender: nil)
    }
    
    @IBAction func closeDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}

/*
 func searchPlaceGoogle(place: String)  {
 //  var seaGooglePApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(place)&key=AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis"
 DispatchQueue.main.async {
 Alamofire.request("https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(place)&key=AIzaSyDTAiyrJrXTmIFnMMRY3qgrak6WAgUNLUQ").responseJSON(completionHandler: {(response) in
 switch response.result{
 case.success(let value):
 let json = JSON(value)
 print(json)
 case.failure(let error):
 print(error.localizedDescription)
 
 }
 })
 }
 } */

